package webrouter

import (
	"net/http"
	"time"
)

var (
	DefaultRouter = NewRouteManager("", "", 0)
	DefaultServer = http.Server{
		ReadTimeout:  1 * time.Minute,
		WriteTimeout: 1 * time.Minute,
	}
)

func FilterPrefix(filterPrefix string) {
	DefaultRouter.FilterPrefix(filterPrefix)
}

func AppendSuffix(appendSuffix string) {
	DefaultRouter.AppendSuffix(appendSuffix)
}

func DelimiterStyle(delimiterStyle byte) {
	DefaultRouter.DelimiterStyle(delimiterStyle)
}

func Registers() map[string]interface{} {
	return DefaultRouter.Registers()
}

func Register(patternRoot string, i interface{}) {
	DefaultRouter.Register(patternRoot, i)
}

func Handle(pattern string, handler http.Handler) {
	DefaultRouter.ServeMux.Handle(pattern, handler)
}

func HandleFunc(pattern string, handler func(http.ResponseWriter, *http.Request)) {
	DefaultRouter.ServeMux.HandleFunc(pattern, handler)
}

func Handler(req *http.Request) (h http.Handler, pattern string) {
	return DefaultRouter.ServeMux.Handler(req)
}

func NotFoundHandler(error string) {
	DefaultRouter.NotFoundHandler(error)
}

func NotFoundHtmlHandler(error string) {
	DefaultRouter.NotFoundHtmlHandler(error)
}

func ServeHTTP(w http.ResponseWriter, req *http.Request) {
	DefaultRouter.ServeHTTP(w, req)
}

func Injector(name, follower string, priority uint, handler func(http.ResponseWriter, *http.Request) bool) {
	DefaultRouter.Injector(name, follower, priority, handler)
}

func SortInjector() {
	DefaultRouter.SortInjector()
}

func Releasor(name, leader string, lag uint, handler func(http.ResponseWriter, *http.Request) bool) {
	DefaultRouter.Releasor(name, leader, lag, handler)
}

func SortReleasor() {
	DefaultRouter.SortReleasor()
}

func ListenAndServe(addr string, handler http.Handler) error {
	DefaultServer.Addr = addr
	if handler == nil {
		DefaultServer.Handler = DefaultRouter
	} else {
		DefaultServer.Handler = handler
	}

	return DefaultServer.ListenAndServe()
}

func ListenAndServeTLS(addr, certFile, keyFile string, handler http.Handler) error {
	DefaultServer.Addr = addr
	if handler == nil {
		DefaultServer.Handler = DefaultRouter
	} else {
		DefaultServer.Handler = handler
	}

	return DefaultServer.ListenAndServeTLS(certFile, keyFile)
}
