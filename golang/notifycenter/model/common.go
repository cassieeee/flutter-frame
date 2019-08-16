package model

const (
	SenderTypeMail = iota
	SenderTypeSMS
	SenderTypeAPP
	SenderTypeMap //公众号
	SenderTypeWeb //Web
	SenderTypeSNS //社交
)

/*
"@notify_data": { //通用字段
	"type": "type", //sms,mail,app等等
	"header": "header", //非必须
	"from": "from", //非必须
	"to": "to",
	"subject": "subject", //非必须
	"plain": "plain",
	"html": "html" //非必须
},
"@sender": { //通用字段
	"type": "type", //sms,mail,app等等
	"can_relay": "can_relay", //是否支持中继转发
	"scheme": "scheme",
	"ip": "ip",
	"inner_ip": "inner_ip",
	"port": "port",
	"check_object": "check_object",
	"extend": "extend" //gob,json等序列号后数据,如：mail的"dkim": {"crypto" : <crypto>,"private" : <private>,"public" : <public>,"selector" : <selector>}
}
*/

type NotifyData struct {
	Type            uint8  `json:"type" bson:"type"` //复用SenderTypeXXX的类型值
	Header          string `json:"header" bson:"header"`
	From            string `json:"from" bson:"from"`
	CheckObjectFrom string `json:"check_object_from" bson:"check_object_from"` //统一在记录时小写化:type为mail时,check_object_from为from的@的domain，如：from:fook@163.com的check_object_from为163.com
	To              string `json:"to" bson:"to"`
	CheckObjectTo   string `json:"check_object_to" bson:"check_object_to"` //统一在记录时小写化:type为mail时,check_object_to@的domain，如：to:fook@163.com的check_object_to为163.com
	Subject         string `json:"subject" bson:"subject"`
	Plain           string `json:"plain" bson:"plain"`
	HTML            string `json:"html" bson:"html"`
}

type Sender struct {
	Type        uint8  `json:"type" bson:"type"` //SenderTypeXXX的值
	CanRelay    bool   `json:"can_relay" bson:"can_relay"`
	Scheme      string `json:"scheme" bson:"scheme"`
	IP          string `json:"ip" bson:"ip"`
	InnerIP     string `json:"inner_ip" bson:"inner_ip"`
	Port        string `json:"port" bson:"port"`
	CheckObject string `json:"check_object" bson:"check_object"` //如mail的发送者的域名(fook@163.com的163.com)：sender_domain等等作为check_object
	Extend      []byte `json:"extend" bson:"extend"`             //根据type的extend的struct来gob.encode编码成字符串，使用时，需要根据type的extend的struct来gob.decode，如：SenderExtendMail
}

type SenderExtendMailDKIM struct {
	Crypto   string `json:"crypto" bson:"crypto"`
	Private  string `json:"private" bson:"private"`
	Public   string `json:"public" bson:"public"`
	Selector string `json:"selector" bson:"selector"`
}

type SenderExtendMail struct {
	Info map[string]string    `json:"info,omitempty" bson:"info,omitempty"`
	DKIM SenderExtendMailDKIM `json:"dkim,omitempty" bson:"dkim,omitempty"`
}

type SenderExtendSMS struct {
	Info map[string]string `json:"info,omitempty" bson:"info,omitempty"`
}

type SenderExtendAPP struct {
	Info map[string]string `json:"info,omitempty" bson:"info,omitempty"`
}

type SenderExtendMap struct {
	Info map[string]string `json:"info,omitempty" bson:"info,omitempty"`
}

type SenderExtendWeb struct {
	Info map[string]string `json:"info,omitempty" bson:"info,omitempty"`
}

type SenderExtendSNS struct {
	Info map[string]string `json:"info,omitempty" bson:"info,omitempty"`
}