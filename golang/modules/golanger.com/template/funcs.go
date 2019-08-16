package template

import (
	"golanger.com/log"
	"io"
	"text/template"
)

var (
	extFunc = FuncMap{
		"op": operator,
	}
)

func AddFunc(name string, i interface{}) {
	if _, ok := extFunc[name]; !ok {
		extFunc[name] = i
	} else {
		log.Warn("<AddFunc> ", "func:"+name+" be added,do not repeat to add")
	}
}

func DelFunc(name string) {
	if _, ok := extFunc[name]; ok {
		delete(extFunc, name)
	}
}

func HTMLEscape(w io.Writer, b []byte) {
	template.HTMLEscape(w, b)
}

func HTMLEscapeString(s string) string {
	return template.HTMLEscapeString(s)
}

func HTMLEscaper(args ...interface{}) string {
	return template.HTMLEscaper(args...)
}

func JSEscape(w io.Writer, b []byte) {
	template.JSEscape(w, b)
}

func JSEscapeString(s string) string {
	return template.JSEscapeString(s)
}

func JSEscaper(args ...interface{}) string {
	return template.JSEscaper(args...)
}

func URLQueryEscaper(args ...interface{}) string {
	return template.URLQueryEscaper(args...)
}
