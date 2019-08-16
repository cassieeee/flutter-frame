package utils

import (
	"net/http"
	"strconv"
	"time"
)

/*
cookie[0] => name string
cookie[1] => value string
cookie[2] => path string
cookie[3] => domain string
cookie[4] => expires int
cookie[5] => maxAge int
cookie[6] => secure bool
cookie[7] => httpOnly bool
cookie[8] => sameSite http.SameSite
*/
func SetCookie(w http.ResponseWriter, target map[string]string, args ...interface{}) *http.Cookie {
	if len(args) < 2 {
		return nil
	}

	const LEN = 9
	var cookie = [LEN]interface{}{}

	for k, v := range args {
		if k >= LEN {
			break
		}

		cookie[k] = v
	}

	var (
		name     string
		value    string
		path     string
		domain   string
		expires  int
		maxAge  int
		secure   bool
		httpOnly bool
		sameSite http.SameSite
	)

	if v, ok := cookie[0].(string); ok {
		name = v
	} else {
		return nil
	}

	if v, ok := cookie[1].(string); ok {
		value = v
	} else {
		return nil
	}

	if v, ok := cookie[2].(string); ok {
		path = v
	}

	if v, ok := cookie[3].(string); ok {
		domain = v
	}

	if v, ok := cookie[4].(int64); ok {
		expires = int(v)
	}

	if v, ok := cookie[5].(int); ok {
		maxAge = v
	}

	if v, ok := cookie[6].(bool); ok {
		secure = v
	}

	if v, ok := cookie[7].(bool); ok {
		httpOnly = v
	}

	if v, ok := cookie[8].(http.SameSite); ok {
		sameSite = v
	}

	pCookie := &http.Cookie{
		Name:     name,
		Value:    value,
		Path:     path,
		Domain:   domain,
		MaxAge:maxAge,
		Secure:   secure,
		HttpOnly: httpOnly,
		SameSite : sameSite,
	}

	if expires != 0 {
		d, _ := time.ParseDuration(strconv.Itoa(expires) + "s")
		pCookie.Expires = time.Now().Add(d)

		if target != nil {
			if expires > 0 {
				target[pCookie.Name] = pCookie.Value
			} else {
				delete(target, pCookie.Name)
			}
		}
	}

	http.SetCookie(w, pCookie)

	return pCookie
}
