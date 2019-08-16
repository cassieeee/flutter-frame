package utils

import (
	"crypto/md5"
	"crypto/sha512"
	"encoding/base64"
	"fmt"
	"io"
	"strings"

	"golanger.com/utils/uuid"
)

type Strings string

func NewString(i interface{}) Strings {
	s := Strings(fmt.Sprintf("%v", i))
	return s
}

func (s Strings) String() string {
	return string(s)
}

func (s Strings) Md5() string {
	m := md5.New()
	io.WriteString(m, s.String())

	return fmt.Sprintf("%x", m.Sum(nil))
}

// delimiterStyle: '-'
// convert like this: "HelloWorld" to "hello-world"
func (s Strings) SnakeCasedNameByDelimiterStyle(delimiterStyle rune) string {
	newstr := make([]rune, 0)
	firstTime := true

	for _, chr := range string(s) {
		if isUpper := 'A' <= chr && chr <= 'Z'; isUpper {
			if firstTime == true {
				firstTime = false
			} else {
				newstr = append(newstr, delimiterStyle)
			}
			chr -= ('A' - 'a')
		}
		newstr = append(newstr, chr)
	}

	return string(newstr)
}

// convert like this: "HelloWorld" to "hello_world"
func (s Strings) SnakeCasedName() string {
	return s.SnakeCasedNameByDelimiterStyle('_')
}

// delimiterStyle: '-'
// convert like this: "hello-world" to "HelloWorld"
func (s Strings) TitleCasedNameByDelimiterStyle(delimiterStyle rune) string {
	newstr := make([]rune, 0)
	upNextChar := true

	for _, chr := range string(s) {
		switch {
		case upNextChar:
			upNextChar = false
			chr -= ('a' - 'A')
		case chr == delimiterStyle:
			upNextChar = true
			continue
		}

		newstr = append(newstr, chr)
	}

	return string(newstr)
}

// convert like this: "hello_world" to "HelloWorld"
func (s Strings) TitleCasedName() string {
	return s.TitleCasedNameByDelimiterStyle('_')
}

func (s Strings) PluralizeString() string {
	str := string(s)
	if strings.HasSuffix(str, "y") {
		str = str[:len(str)-1] + "ie"
	}
	return str + "s"
}

func (s Strings) GenerateSecret(secret string) string {
	h := sha512.New()
	h.Write([]byte(string(s)))
	newUUID := uuid.NewMD5(uuid.Must(uuid.NewRandom()), []byte(secret))
	newSecret := base64.URLEncoding.EncodeToString(h.Sum(newUUID.Bytes()))
	newSecret = strings.TrimRight(newSecret, "=")
	return newSecret
}
