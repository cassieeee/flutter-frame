package main

import (
	"flag"
	"fmt"
	"net/http"
	"runtime"

	_ "golanger/controllers"

	"golanger.com/webrouter"
)

var (
	addr = flag.String("addr", ":80", "Server port")
)

func main() {
	runtime.GOMAXPROCS(runtime.NumCPU()*2 - 1)

	flag.Parse()
	fmt.Println("Listen server address: " + *addr)

	webrouter.HandleFunc("/favicon.ico", func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("favicon.ico")
	})

	webrouter.ListenAndServe(*addr, nil)
}
