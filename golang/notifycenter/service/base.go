package service

import (
	"compress/gzip"
	"io/ioutil"
	"net/http"

	"golanger.com/db/mongodb"
	"golanger.com/log"
)

type Base struct {
	M mongodb.Mongoer
}

func NewBase(mgo mongodb.Mongoer) *Base {
	return &Base{
		M: mgo,
	}
}

func (b *Base) Init(rw http.ResponseWriter, req *http.Request) {
	accept := req.Header.Get("Content-Encoding")
	if accept == "gzip" {
		log.Debug("find gzip to uncompressed")
		if gzr, err := gzip.NewReader(req.Body); err != nil {
			log.Error("gzip reader error:", err)
		} else {
			req.Body = gzr
		}
	}

	switch req.Method {
	case "GET":
		switch req.Header.Get("Content-Type") {
		case "application/x-www-form-urlencoded":
			if bBody, err := ioutil.ReadAll(req.Body); err != nil {
				log.Error("ReadAll body error:", err)
			} else {
				req.URL.RawQuery = string(bBody)
			}
		}
	case "POST", "PUT":
		switch req.Header.Get("Content-Type") {
		case "application/x-www-form-urlencoded":
			req.ParseForm()
		}
	}
}

func (b *Base) After(rw http.ResponseWriter, req *http.Request) {
	http.NotFound(rw, req)
}
