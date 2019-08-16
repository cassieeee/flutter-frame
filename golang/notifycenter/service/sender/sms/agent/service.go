package agent

import (
	"bytes"
	"encoding/gob"
	"encoding/json"
	"io/ioutil"
	"net"
	"net/http"
	"net/url"
	"notifycenter/model"
	"notifycenter/service"
	"strconv"
	"strings"
	"time"

	"go.mongodb.org/mongo-driver/bson/primitive"
	"golanger.com/cache"
	"golanger.com/log"
	ghttp "golanger.com/net/http"
	gclient "golanger.com/net/http/client"
	"golanger.com/utils"
	"golanger.com/validator"
)

const (
	LOG_SENDER string = "log_sender"
)

func init() {
	gob.Register(model.NotifyData{})
	gob.Register(model.LogSender{})
	gob.Register(model.SenderExtendSMS{})
}

type Sender struct {
	*service.Base
	caches                     *cache.Cache
	logSenderHost              string
	logSenderLogRequestPath    string
	resourcesHost              string
	resourcesExtendRequestPath string //Info
	resourcesCallBackURL       string
	tryOnTimedOut              int
	cacheExtendDuration        time.Duration
	cacheCallbackURLDuration   time.Duration
}

func NewSender(b *service.Base,
	caches *cache.Cache,
	logSenderHost, logSenderLogRequestPath, resourcesHost, resourcesExtendRequestPath, resourcesCallBackURL string,
	tryOnTimedOut int,
	cacheExtendDuration time.Duration,
	cacheCallbackURLDuration time.Duration) *Sender {
	return &Sender{
		Base:                       b,
		caches:                     caches,
		logSenderHost:              logSenderHost,
		logSenderLogRequestPath:    logSenderLogRequestPath,
		resourcesHost:              resourcesHost,
		resourcesExtendRequestPath: resourcesExtendRequestPath,
		resourcesCallBackURL:       resourcesCallBackURL,
		tryOnTimedOut:              tryOnTimedOut,
		cacheExtendDuration:        cacheExtendDuration,
		cacheCallbackURLDuration:   cacheCallbackURLDuration,
	}
}

func (s *Sender) RouteSend() {}

func (s *Sender) Http_PUT_Send(rw http.ResponseWriter, req *http.Request) bool {
	client := req.FormValue("client")
	receivedIDHex := req.FormValue("received_id")
	senderObject := req.FormValue("sender_object")
	innerIP := req.FormValue("inner_ip")
	notifyDataStr := req.FormValue("data")
	valid := &validator.Validation{}
	valid.Required(client).Key("client").Message("client字段为空")
	valid.Required(receivedIDHex).Key("received_id").Message("received_id字段为空")
	valid.Required(senderObject).Key("sender_object").Message("sender_object字段为空")
	valid.Required(notifyDataStr).Key("data").Message("data字段为空")

	var notifyData model.NotifyData
	if valid.HasErrors() {
		rw.WriteHeader(http.StatusBadRequest)
		log.Error("vakid error map:", valid.ErrorMap())
	} else if receivedID, hexErr := primitive.ObjectIDFromHex(receivedIDHex); hexErr != nil {
		rw.WriteHeader(http.StatusBadRequest)
		log.Error("ObjectIDFromHex receivedID:", receivedIDHex, " error:", hexErr)
	} else if gobDeErr := ghttp.GobDecode([]byte(notifyDataStr), &notifyData); gobDeErr != nil {
		rw.WriteHeader(http.StatusBadRequest)
		log.Error("GobDecode notifyDataStr:", notifyDataStr, " error:", gobDeErr)
	} else {
		//获取extend属性
		senderExtend := s.getExtend(strconv.Itoa(int(notifyData.Type)), senderObject)
		if senderExtend.Info == nil {
			rw.WriteHeader(http.StatusBadRequest)
			log.Error("GobDecode notifyDataStr:", notifyDataStr, " error:", gobDeErr)
			return true
		}

		log.Debug("send sms receivedID:", receivedID)
		//Sender逻辑开始
		requestURL := senderExtend.Info["request_host"] +
			senderExtend.Info["send_sms_path"] +
			"?action=" +
			senderExtend.Info["action"] +
			"&userid=" +
			senderExtend.Info["userid"] +
			"&account=" +
			senderExtend.Info["account"] +
			"&password=" +
			senderExtend.Info["password"] +
			"&mobile=" +
			notifyData.To +
			"&content=" +
			notifyData.Plain +
			"&sendTime=&extno=" +
			senderExtend.Info["extno"]

		if res, resErr := gclient.NewClient().Get(requestURL); resErr != nil {
			log.Error("client get url:", requestURL, " error", resErr)
		} else {
			//Sender逻辑结束
			defer res.Body.Close()
			senderIP, _, _ := net.SplitHostPort(req.Host)

			//如果配置内网IP则设置内网IP
			if innerIP != "" {
				senderIP = innerIP
			}

			log.Debug("senderIP:", senderIP)
			responseCode := strconv.Itoa(res.StatusCode)
			var responseMessage string

			if body, err := ioutil.ReadAll(res.Body); err != nil {
				log.Error("read resp.Body error:", err)
			} else {
				responseMessage = string(body)

				go s.putLogSender(model.LogSender{
					SenderObject: model.LogSenderSenderObject{
						IP:     senderIP,
						Object: senderObject,
					},
					Client:          client,
					ReceivedID:      receivedID,
					Data:            notifyData,
					SourceData:      notifyData.Plain,
					ResponseCode:    responseCode,
					ResponseMessage: responseMessage,
				})

				log.Info("[", client, "]", ", receivedID:", receivedIDHex,
					", SenderIP:", senderIP,
					", Subject:", notifyData.Subject,
					", From:", notifyData.From,
					", To:", notifyData.To,
					", Response:", responseCode, " ", responseMessage)
			}
		}
	}

	return true
}

func (s *Sender) putLogSender(logSender model.LogSender) {
	if gobData, err := ghttp.GobEncode(logSender); err != nil {
		log.Error("GobEncode logSender:", logSender, " error:", err)
	} else {
		data := url.Values{}
		data.Add("data", string(gobData))
		logSenderURL := s.logSenderHost + s.logSenderLogRequestPath
		if resp, respErr := gclient.NewClient().Gzip().PutForm(logSenderURL, data); respErr != nil {
			log.Error("PutForm client:", logSender.Client, " receivedID:", logSender.ReceivedID.Hex(), " error:", respErr)
		} else {
			defer resp.Body.Close()
			if resp.StatusCode == 200 {
				go s.putCallbackURL(logSender, time.Now().Unix())
				if body, err := ioutil.ReadAll(resp.Body); err == nil {
					log.Info("[", logSender.Client, "]",
						" Put Log receivedID:", logSender.ReceivedID.Hex(),
						", SenderIP:", logSender.SenderObject.IP,
						", Subject:", logSender.Data.Subject,
						", From:", logSender.Data.From,
						", To:", logSender.Data.To,
						", Response:", string(body))
				} else {
					log.Error("read resp.Body error:", err)
				}
			} else {
				log.Error("PutForm client:", logSender.Client,
					", receivedID:", logSender.ReceivedID.Hex(),
					", SenderIP:", logSender.SenderObject.IP,
					", Subject:", logSender.Data.Subject,
					", From:", logSender.Data.From,
					", To:", logSender.Data.To,
					", url:", logSenderURL,
					", status:", resp.Status,
					", error:", respErr)
			}
		}
	}
}

func (s *Sender) putCallbackURL(logSender model.LogSender, sendTime int64) {
	var callbackURL string
	if callbackURL = s.getCallBackURL(logSender.Client, strconv.Itoa(int(logSender.Data.Type)), LOG_SENDER, logSender.SenderObject.Object); callbackURL == "" {
		return
	}
	callbackURLs := strings.Split(callbackURL, "@")
	if len(callbackURLs) == 2 {
		callback := callbackURLs[0]
		callbackFields := strings.Split(callback, ",")
		backURL := callbackURLs[1]
		if backURL != "" {
			logSenderStruct := utils.Struct{
				I: logSender,
			}
			logSenderMap := logSenderStruct.StructToMap()
			log.Debug("logSenderMpa: ", logSenderMap)
			returnMap := utils.M{}

			returnSenderObjectMap := logSenderMap["sender_object"].(utils.M)
			returnMap["sender_object.ip"] = returnSenderObjectMap["ip"]
			returnMap["sender_object.object"] = returnSenderObjectMap["object"]

			returnMap["received_id"] = logSenderMap["received_id"]
			returnMap["send_time"] = sendTime
			returnMap["response_code"] = logSenderMap["response_code"]
			returnMap["response_message"] = logSenderMap["response_message"]
			returnSenderDataMap := logSenderMap["data"].(utils.M)
			for _, v := range callbackFields {
				if v == "receiver_object" {
					returnReceiverObjectMap := logSenderMap["receiver_object"].(utils.M)
					returnMap["receiver_object.ip"] = returnReceiverObjectMap["ip"]
					returnMap["receiver_object.object"] = returnReceiverObjectMap["object"]
				} else {
					if fieldValue, found := returnSenderDataMap[v]; found && fieldValue != "" {
						returnMap["data."+v] = fieldValue
					}
				}
			}

			if returnJSON, err := json.Marshal(returnMap); err != nil {
				log.Error("callback_str:", string(returnJSON), " err:", err)
			} else {
				bData := url.Values{}
				bData.Add("data", string(returnJSON))
				if resp, respErr := gclient.NewClient().PutForm(backURL, bData); respErr != nil {
					log.Error("callback resp:", resp, " error:", respErr)
				} else {
					defer resp.Body.Close()
					if resp.StatusCode == 200 {
						log.Info("client:", logSender.Client, " callback url:", backURL)
					}
				}
			}
		}
	}
}

func (s *Sender) getExtend(typ, checkObject string) (extend model.SenderExtendSMS) {
	cacheKey := "extend." + checkObject
	if extendCache, found := s.caches.Get(cacheKey); found {
		extend = extendCache.(model.SenderExtendSMS)
		log.Debug("found extend by Cache:", extend)
	} else {
		resourcesURL := s.resourcesHost + s.resourcesExtendRequestPath
		if resp, err := gclient.NewClient().Gzip().Get(resourcesURL + "?type=" + typ + "&check_object=" + url.QueryEscape(checkObject)); err != nil {
			log.Error("get sender error:", err)
			return
		} else {
			defer resp.Body.Close()
			if resp.StatusCode != 200 {
				log.Error("get sender status code:", resp.StatusCode, " error:", err)
				return
			}

			if body, err := ioutil.ReadAll(resp.Body); err != nil {
				log.Error("get sender error:", err)
				return
			} else {
				if !bytes.Equal(body, []byte("")) {
					if err := ghttp.GobDecode(body, &extend); err != nil {
						log.Error("get sender error:", err)
						return
					} else {
						s.caches.Set(cacheKey, extend, s.cacheExtendDuration)
					}
				}
			}
		}
	}

	return
}

func (s *Sender) getCallBackURL(client, typ, key, checkObject string) (rtnURL string) {
	cackekey := "callback_url." + client + "." + checkObject + "." + key
	if urlCache, found := s.caches.Get(cackekey); found {
		log.Debug("found url by Cache:", urlCache)
		rtnURL = urlCache.(string)
	} else {
		resourcesURL := s.resourcesHost + s.resourcesCallBackURL
		if resp, err := gclient.NewClient().Gzip().Get(resourcesURL + "?client=" + client + "&type=" + typ + "&key=" + url.QueryEscape(key) + "&check_object=" + checkObject); err != nil {
			log.Error("get callback url error:", err)
		} else {
			defer resp.Body.Close()
			if resp.StatusCode != 200 {
				log.Error("get callback url code:", resp.StatusCode, " error:", err)
				return
			}

			if body, err := ioutil.ReadAll(resp.Body); err != nil {
				log.Error("get callback url error:", err)
			} else {
				rtnURL = string(body)
				s.caches.Set(cackekey, rtnURL, s.cacheCallbackURLDuration)
				log.Debug("found url by sender info:", rtnURL)
			}
		}
	}

	return
}
