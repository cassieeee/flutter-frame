package main

import (
	"net/http"
)

type PageIndex struct {
}

func (p *PageIndex) RouteIndex(rw http.ResponseWriter) {
	rw.Write([]byte(`<a href="/uid/999/uname/liwei">测试重写是否生效</a>`))
}

func (p *PageIndex) RouteGo(rw http.ResponseWriter, r *http.Request) {
	rw.Write([]byte(`<a href="/index">返回</a>`+r.URL.String()))
}