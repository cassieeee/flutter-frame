package service

type Config struct {
	MaxProcs               int    `json:"max_procs"`
	BindHost               string `json:"bind_host"`
	ServerReadTimeOut      string `json:"server_read_time_out"`
	ServerWriteTimeOut     string `json:"server_write_time_out"`
	SslCertFile            string `json:"ssl_cert_file"`
	SslKeyFile             string `json:"ssl_key_file"`
	MongoDNS               string `json:"mongo_dns"`
	MongoDatabaseName      string `json:"mongo_database_name"`
	LocateRelativeExecPath bool   `json:"locate_relative_exec_path"`
	LogDir                 string `json:"log_dir"`
	LogFile                string `json:"log_file"`
	LogDebugLevel          string `json:"log_debug_level"`
}
