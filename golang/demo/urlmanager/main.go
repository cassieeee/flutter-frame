package main

import (
	"flag"
	"fmt"
	"golanger.com/urlmanager"
	"golanger.com/webrouter"
	"net/http"
	"net/url"
	"runtime"
)

var (
	addr       = flag.String("addr", ":80", "Server port")
	urlManager = urlmanager.New()
)

func init() {
	webrouter.NotFoundHtmlHandler(`404`)
	webrouter.Register("/", &PageIndex{})

	urlManager.Start()
	urlManager.LoadRule(`
^/$		/index		[R=302.L]
^/uid/(\d{1,})/uname/(\w{1,})$	/go?uid=${1}&uname=${2}	[L]
`, false)
}

func main() {
	runtime.GOMAXPROCS(runtime.NumCPU()*2 - 1)

	flag.Parse()
	fmt.Println("Listen server address: " + *addr)

	webrouter.Injector("urlmanager", "", 0, func(w http.ResponseWriter, r *http.Request) (ret bool) {
		newUrl := urlManager.ReWrite(w, r)
		if newUrl == "redirect" {
			ret = true
		} else {
			r.URL, _ = url.Parse(newUrl)
		}

		return
	})

	webrouter.ListenAndServe(*addr, nil)
}
