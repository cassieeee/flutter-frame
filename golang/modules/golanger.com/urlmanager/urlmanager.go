package urlmanager

import (
	"golanger.com/log"
	"net/http"
	"regexp"
	"strconv"
	"strings"
	"sync"
)

func parse(r string) (string, string, []flag) {
	var expr, replace string
	var flags []flag
	r = regexp.MustCompile(`[[:blank:]]+`).ReplaceAllString(r, "`")
	rs := strings.Split(r, "`")
	lrs := len(rs)
	if lrs >= 2 {
		expr = rs[0]
		replace = rs[1]
		if lrs >= 3 {
			flagss := strings.Split(strings.Trim(rs[2], `[]`), ",")
			for _, f := range flagss {
				if f == "NC" {
					expr = `(?i)` + expr
					continue
				}

				var fl flag
				fs := strings.Split(f, "=")
				fl = flag{
					name: fs[0],
				}
				if len(fs) > 1 {
					fl.param = fs[1]
				}

				flags = append(flags, fl)
			}
		}
	}

	return expr, replace, flags
}

/*
NC - Nocase:URL地址匹配对大小写敏感
S - Skip:忽略之后的规则
R - Redirect:发出一个HTTP重定向
N - Next:再次从第一个规则开始处理，但是使用当前重写后的URL地址
L - Last:停止处理接下来的规则
QSA - Qsappend:在新的URL地址后附加查询字符串部分，而不是替代
*/
type flag struct {
	name  string
	param string
}

type rule struct {
	regexp  *regexp.Regexp
	replace string
	flags   []flag
}

type UrlManager struct {
	manage    bool
	mustMatch bool
	rules     []rule
	mutex     sync.RWMutex
	urlCache  map[string]string
}

func New() *UrlManager {
	return &UrlManager{}
}

func (u *UrlManager) Cache() bool {
	return u.mustMatch
}

func (u *UrlManager) SetCache(cache bool) {
	u.mutex.Lock()
	u.mustMatch = !cache
	u.mutex.Unlock()
}

func (u *UrlManager) RefreshCache() {
	u.mutex.Lock()
	u.urlCache = map[string]string{}
	u.mutex.Unlock()
}

func (u *UrlManager) Manage() bool {
	return u.manage
}

func (u *UrlManager) Start() {
	u.mutex.Lock()
	u.manage = true
	u.mutex.Unlock()
}

func (u *UrlManager) Stop() {
	u.mutex.Lock()
	u.manage = false
	u.mutex.Unlock()
}

func (u *UrlManager) addRule(expr, replace string, flags ...flag) {
	if expr == "" || replace == "" {
		log.Warn("UrlManager.addUrl: expr and reolace is empty")
		return
	}

	r, err := regexp.Compile(expr)
	if err != nil {
		log.Warn("UrlManager.addUrl: regexp compile failed - ", err)
		return
	}

	rl := rule{
		regexp:  r,
		replace: replace,
		flags:   flags,
	}

	u.mutex.Lock()
	u.rules = append(u.rules, rl)
	u.mutex.Unlock()
}

func (u *UrlManager) doRule(rw http.ResponseWriter, req *http.Request) string {
	var match bool
	var out string

	reqUrl := req.URL
	in := reqUrl.Path

	u.mutex.RLock()
	lrs := len(u.rules)
	u.mutex.RUnlock()

RESTART:
	for i := 0; i < lrs; i++ {
		u.mutex.RLock()
		ur := u.rules[i]
		u.mutex.RUnlock()
		if !ur.regexp.MatchString(in) {
			continue
		}

		var skip bool
		var restart bool
		var last bool
		var redirect bool
		var redirectCode int
		var queryStringAppend bool

		if len(ur.flags) > 0 {
			for _, f := range ur.flags {
				switch f.name {
				case "R":
					redirect = true
					redirectCode, _ = strconv.Atoi(f.param)
					if redirectCode == 0 {
						redirectCode = http.StatusFound
					}
				case "S":
					skip = true
					skipNum, _ := strconv.Atoi(f.param)
					//循环后会自动加1，所以这里减1
					skipNum = skipNum - 1
					if skipNum > 0 {
						i = i + skipNum
					}
				case "N":
					restart = true
				case "L":
					last = true
				case "QSA":
					queryStringAppend = true
				}
			}
		}

		out = ur.regexp.ReplaceAllString(in, ur.replace)

		if out != in {
			match = true
		}

		if queryStringAppend {
			if strings.Contains(out, "?") {
				out += "&" + reqUrl.RawQuery
			} else {
				if rawQuery := reqUrl.RawQuery; rawQuery != "" {
					out += "?" + reqUrl.RawQuery
				}
			}
		}

		if redirect {
			http.Redirect(rw, req, out, redirectCode)
			return `redirect`
		}

		if skip {
			continue
		}

		if restart {
			in = out
			goto RESTART
		}

		if last {
			break
		}
	}

	if !match {
		return reqUrl.String()
	} else {
		if !u.mustMatch {
			u.mutex.Lock()
			u.urlCache[reqUrl.String()] = out
			u.mutex.Unlock()
		}
	}

	return out
}

func (u *UrlManager) clearRule() {
	u.mutex.Lock()
	defer u.mutex.Unlock()
	u.rules = make([]rule, 0)
}

func (u *UrlManager) loadRule(rules string) {
	for _, r := range strings.Split(rules, "\n") {
		u.AddRule(r)
	}
}

func (u *UrlManager) AddRule(r string) {
	expr, replace, flags := parse(r)
	u.addRule(expr, replace, flags...)
}

func (u *UrlManager) ReWrite(rw http.ResponseWriter, req *http.Request) string {
	u.mutex.RLock()
	manage := u.manage
	cache := !u.mustMatch
	u.mutex.RUnlock()
	if !manage {
		return req.URL.String()
	}

	if cache {
		if u.urlCache == nil {
			u.urlCache = map[string]string{}
		}

		if to, ok := u.urlCache[req.URL.String()]; ok {
			return to
		}
	}

	return u.doRule(rw, req)
}

func (u *UrlManager) LoadRule(rules string, reload bool) {
	if reload {
		u.clearRule()
	}

	u.loadRule(strings.TrimSpace(rules))
}
