package controllers

import (
	"golanger.com/webrouter"
)

func init() {
	webrouter.NotFoundHtmlHandler(`404`)
	webrouter.Register("/", &PageIndex{})
}
