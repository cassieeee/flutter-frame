package http

import (
	"encoding/json"
	"net/http"
)

func ResponseJson(rw http.ResponseWriter, data interface{}) {
	rw.Header().Set("cache-control", "no-cache")
	rw.Header().Set("Content-Type", "application/json; charset=utf-8")
	jsonData, err := json.Marshal(data)
	if err != nil {
		rw.Write([]byte(`{"error":"invalid json format"}`))
		return
	}
	rw.Write(jsonData)
}

func ResponseText(rw http.ResponseWriter, data []byte) {
	rw.Header().Set("cache-control", "no-cache")
	rw.Header().Set("Content-Type", "text/plain; charset=utf-8")
	rw.Write(data)
}
