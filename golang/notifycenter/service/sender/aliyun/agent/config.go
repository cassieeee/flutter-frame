package agent

import (
	"notifycenter/service"
)

type SenderInfo struct {
	CanRelay    bool              `json:"can_relay"`
	Scheme      string            `json:"scheme"`
	IP          string            `json:"ip"`
	InnerIP     string            `json:"inner_ip"`
	Port        string            `json:"port"`
	CheckObject string            `json:"check_object"`
	ExtendInfo  map[string]string `json:"extend_info"`
}

type Config struct {
	service.Config
	Client                         string     `json:"client"`
	Secret                         string     `json:"secret"`
	AutoRegister                   bool       `json:"auto_register"`
	SenderInfo                     SenderInfo `json:"sender_info"`
	LogSenderHost                  string     `json:"log_sender_host"`
	LogSenderLogRequestPath        string     `json:"log_sender_log_request_path"`
	ResourcesHost                  string     `json:"resources_host"`
	ResourcesExtendRequestPath     string     `json:"resources_extend_request_path"`
	ResourcesCallbackURLPath       string     `json:"resources_callback_url_path"`
	ResourcesSenderRegisterURLPath string     `json:"resources_sender_register_path"`
	TryOnTimedOut                  int        `json:"try_on_time_out"`
	CacheExtendDuration            string     `json:"cache_extend_duration"`
	CacheCallbackURLDuration       string     `json:"cache_callback_url_duration"`
}
