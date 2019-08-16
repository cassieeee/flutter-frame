package memorysession

import (
	"crypto/rand"
	"encoding/base64"
	"io"
	"net/http"
	"sync"
	"time"

	"golanger.com/mapping"
	"golanger.com/utils"
)

type Session struct {
	Create time.Time
	*mapping.Mapping
}

type SessionManager struct {
	CookieName    string
	CookieDomain  string
	rmutex        sync.RWMutex
	mutex         sync.Mutex
	sessions      map[string]Session
	expires       int64
	timerDuration time.Duration
}

func New(cookieName, cookieDomain string, expires int64, timerDuration string) *SessionManager {
	if cookieName == "" {
		cookieName = "GoLangerSession"
	}

	if expires <= 0 {
		expires = 3600 * 24
	}

	var dTimerDuration time.Duration

	if td, terr := time.ParseDuration(timerDuration); terr == nil {
		dTimerDuration = td
	} else {
		dTimerDuration, _ = time.ParseDuration("24h")
	}

	s := &SessionManager{
		CookieName:    cookieName,
		CookieDomain:  cookieDomain,
		sessions:      map[string]Session{},
		expires:       expires,
		timerDuration: dTimerDuration,
	}

	time.AfterFunc(s.timerDuration, func() { s.GC() })

	return s
}

func (s *SessionManager) Start(rw http.ResponseWriter, req *http.Request) Session {
	var sessionSign string

	s.rmutex.RLock()
	defer s.rmutex.RUnlock()
	if c, err := req.Cookie(s.CookieName); err == nil {
		sessionSign = c.Value
		if sessionValue, ok := s.sessions[sessionSign]; ok {
			return sessionValue
		}

	}

	sessionSign = s.new(rw, req)
	return s.sessions[sessionSign]
}

func (s *SessionManager) Flush(rw http.ResponseWriter, req *http.Request) {
	s.rmutex.RLock()
	defer s.rmutex.RUnlock()
	cookieName := s.CookieName

	if c, err := req.Cookie(cookieName); err == nil {
		sessionSign := c.Value
		s.sessions[sessionSign].Flush()
		s.Clear(sessionSign)
		utils.SetCookie(rw, nil, cookieName, "", "", -3600)
	}
}

func (s *SessionManager) Len() int64 {
	s.mutex.Lock()
	defer s.mutex.Unlock()
	return int64(len(s.sessions))
}

func (s *SessionManager) new(rw http.ResponseWriter, req *http.Request) string {
	now := time.Now()
	s.rmutex.RLock()
	cookieName := s.CookieName
	cookieDomain := s.CookieDomain
	sessionSign := s.sessionSign()
	expires := s.expires
	s.rmutex.RUnlock()

	s.mutex.Lock()
	s.sessions[sessionSign] = Session{
		Create:  now,
		Mapping: mapping.New(),
	}
	s.mutex.Unlock()

	req.AddCookie(utils.SetCookie(rw, nil, cookieName, sessionSign, "/", cookieDomain, expires, 0, true, true))
	time.AfterFunc(time.Unix(now.Unix()+expires, 0).Sub(now), func() { s.Clear(sessionSign) })

	return sessionSign
}

func (s *SessionManager) Clear(sessionSign string) {
	s.mutex.Lock()
	defer s.mutex.Unlock()
	delete(s.sessions, sessionSign)
}

func (s *SessionManager) GC() {
	s.rmutex.RLock()
	for sessionSign, sess := range s.sessions {
		if (sess.Create.Unix() + s.expires) <= time.Now().Unix() {
			s.mutex.Lock()
			delete(s.sessions, sessionSign)
			s.mutex.Unlock()
		}
	}

	s.rmutex.RUnlock()

	time.AfterFunc(s.timerDuration, func() { s.GC() })
}

func (s *SessionManager) sessionSign() string {
	var n int = 24
	b := make([]byte, n)
	io.ReadFull(rand.Reader, b)

	//return length:32
	return base64.URLEncoding.EncodeToString(b)
}
