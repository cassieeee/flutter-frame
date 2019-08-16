package main

import (
	"bytes"
	"flag"
	"io/ioutil"
	"net/url"
	"notifycenter/model"
	"notifycenter/service"
	"notifycenter/service/sender/sms/agent"
	"os"
	"path"
	"runtime"
	"strconv"
	"time"

	"golanger.com/cache"
	"golanger.com/config"
	"golanger.com/log"
	ghttp "golanger.com/net/http"
	gclient "golanger.com/net/http/client"
	"golanger.com/webrouter"
)

var (
	confFile = flag.String("f", "./sender-sms-agent.conf", "config file")
)

func main() {
	flag.Parse()
	var conf agent.Config
	config.Files(*confFile).Load(&conf)
	cdpath := ""
	if conf.LocateRelativeExecPath {
		cdpath = path.Dir(os.Args[0]) + "/"
	}

	log.SetLevel(conf.LogDebugLevel)
	log.SetFlags(log.Ldate | log.Ltime | log.Lmicroseconds)
	if conf.LogDir != "" {
		if _, err := os.Stat(cdpath + conf.LogDir); err != nil {
			os.Mkdir(cdpath+conf.LogDir, 0700)
		}
	}

	if conf.LogFile != "" {
		logFi, err := os.OpenFile(cdpath+conf.LogDir+"/"+conf.LogFile, os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0700)
		if err != nil {
			log.Fatalln(err)
		}

		log.SetOutput(logFi)
	}

	runtime.GOMAXPROCS(conf.MaxProcs)

	//Init Begin
	//auto register sender to resource Begin
	if conf.AutoRegister {
		log.Info("auto register sender to resource Begin")
		autoRegisterURL := conf.ResourcesHost + conf.ResourcesSenderRegisterURLPath
		data := url.Values{}
		data.Add("client", conf.Client)
		data.Add("secret", conf.Secret)
		data.Add("type", strconv.Itoa(int(model.SenderTypeSMS)))
		data.Add("can_relay", strconv.FormatBool(conf.SenderInfo.CanRelay))
		data.Add("scheme", conf.SenderInfo.Scheme)
		data.Add("ip", conf.SenderInfo.IP)
		data.Add("inner_ip", conf.SenderInfo.InnerIP)
		data.Add("port", conf.SenderInfo.Port)
		data.Add("check_object", conf.SenderInfo.CheckObject)
		if gobData, gobErr := ghttp.GobEncode(conf.SenderInfo.Extend); gobErr != nil {
			log.Error("client:", conf.Client, " GobEncode conf.SenderInfo.Extend error:", gobErr)
		} else {
			data.Add("extend", string(gobData))
		}

		if resp, respErr := gclient.NewClient().Gzip().PostForm(autoRegisterURL, data); respErr != nil {
			log.Error("PostForm client:", conf.Client, " to auto register resource error:", respErr)
		} else {
			if resp.StatusCode == 200 {
				configPath := *confFile
				if data, err := ioutil.ReadFile(configPath); err != nil {
					log.Error("ReadFile "+configPath+" error: ", err)
				} else {
					if bytes.Contains(data, []byte(`"auto_register":true`)) {
						data = bytes.ReplaceAll(data, []byte(`"auto_register":true`), []byte(`"auto_register":false`))
						ioutil.WriteFile(configPath, data, 0700)
					}
				}
			}
		}

		log.Info("auto register sender to resource End")
	}
	//auto register sender to resource End

	base := service.NewBase(nil)
	caches := cache.New(0, 0)
	//Init End

	//Register Begin
	func() {
		if serRDur, serRDurErr := time.ParseDuration(conf.ServerReadTimeOut); serRDurErr == nil {
			webrouter.DefaultServer.ReadTimeout = serRDur
		} else {
			log.Error("ParseDuration server_read_time_out:", conf.ServerReadTimeOut, " error:", serRDurErr)
		}

		if serWDur, serWDurErr := time.ParseDuration(conf.ServerWriteTimeOut); serWDurErr == nil {
			webrouter.DefaultServer.WriteTimeout = serWDur
		} else {
			log.Error("ParseDuration server_write_time_out:", conf.ServerWriteTimeOut, " error:", serWDurErr)
		}
	}()

	extendDur, tdErr := time.ParseDuration(conf.CacheExtendDuration)
	if tdErr != nil {
		extendDur = 30 * time.Minute
		log.Warn("ParseDuration cache_dkim_duration:", conf.CacheExtendDuration, " error:", tdErr)
	}

	callbackURLDur, tdErr := time.ParseDuration(conf.CacheCallbackURLDuration)
	if tdErr != nil {
		callbackURLDur = 30 * time.Minute
		log.Warn("ParseDuration cache_callback_url_duration:", conf.CacheCallbackURLDuration, " error:", tdErr)
	}

	webrouter.Register("/", agent.NewSender(
		base,
		caches,
		conf.LogSenderHost,
		conf.LogSenderLogRequestPath,
		conf.ResourcesHost,
		conf.ResourcesExtendRequestPath,
		conf.ResourcesCallbackURLPath,
		conf.TryOnTimedOut,
		extendDur,
		callbackURLDur,
	))
	//Register End

	log.Info("Running at", conf.BindHost)
	if conf.SslCertFile != "" && conf.SslKeyFile != "" {
		if err := webrouter.ListenAndServeTLS(conf.BindHost, cdpath+conf.SslCertFile, cdpath+conf.SslKeyFile, nil); err != nil {
			log.Fatalln("ListenAndServeTLS error: ", err)
		}
	} else {
		if err := webrouter.ListenAndServe(conf.BindHost, nil); err != nil {
			log.Fatalln("ListenAndServe error: ", err)
		}
	}
}
