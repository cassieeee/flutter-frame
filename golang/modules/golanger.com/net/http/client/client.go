package client

import (
	"bytes"
	"compress/gzip"
	"crypto/tls"
	"io"
	"net"
	"net/http"
	"net/url"
	"strings"
	"time"

	"golanger.com/log"
	"golanger.com/multipart"
)

type Client struct {
	useGzip bool
	*http.Client
}

func TimeoutDialer(cTimeout, rwTimeout time.Duration) func(netw, addr string) (c net.Conn, err error) {
	return func(netw, addr string) (net.Conn, error) {
		conn, err := net.DialTimeout(netw, addr, cTimeout)
		if err != nil {
			return nil, err
		}

		if rwTimeout > 0 {
			conn.SetDeadline(time.Now().Add(rwTimeout))
		}

		return conn, nil
	}
}

func SkipVerifyAndTimeOutTransport(insecureSkipVerify bool, headerTimeout, connectTimeout, readWriteTimeout time.Duration) *http.Transport {
	return &http.Transport{
		Proxy: http.ProxyFromEnvironment,
		Dial:  TimeoutDialer(connectTimeout, readWriteTimeout),
		TLSClientConfig: &tls.Config{
			InsecureSkipVerify: insecureSkipVerify,
		},
		ResponseHeaderTimeout: headerTimeout,
	}
}

func NewClient() *Client {
	c := &Client{Client: &http.Client{}}
	c.Transport = SkipVerifyAndTimeOutTransport(true, 60*time.Second, 60*time.Second, 2*time.Minute)
	return c
}

func (c *Client) Gzip() *Client {
	c.useGzip = true
	return c
}

func (c *Client) GzipDisAble() *Client {
	c.useGzip = false
	return c
}

func (c *Client) doMethod(method, rawurl string, bodyType string, body io.Reader) (*http.Response, error) {
	req, err := http.NewRequest(method, rawurl, body)
	if err != nil {
		log.Error("<doMethod> NewRequest error:", err)
		return nil, err
	}

	if c.useGzip {
		req.Header.Add("Content-Encoding", "gzip")
	}

	if bodyType != "" {
		req.Header.Set("Content-Type", bodyType)
	}

	resp, respErr := c.Do(req)
	log.Debug("<doMethod> response:", resp, " response error:", respErr)
	return resp, respErr
}

func (c *Client) get(rawurl string, bodyType string, body io.Reader) (*http.Response, error) {
	return c.doMethod("GET", rawurl, bodyType, body)
}

func (c *Client) GetForm(rawurl string, data url.Values) (*http.Response, error) {
	var ir io.Reader
	if c.useGzip {
		bufw := new(bytes.Buffer)
		gzw := gzip.NewWriter(bufw)
		gzw.Write([]byte(data.Encode()))
		gzw.Close()
		ir = bufw
	} else {
		ir = strings.NewReader(data.Encode())
	}

	return c.get(rawurl, "application/x-www-form-urlencoded", ir)
}

func (c *Client) Post(rawurl string, bodyType string, body io.Reader) (*http.Response, error) {
	return c.doMethod("POST", rawurl, bodyType, body)
}

func (c *Client) PostForm(rawurl string, data url.Values) (*http.Response, error) {
	var ir io.Reader
	if c.useGzip {
		bufw := new(bytes.Buffer)
		gzw := gzip.NewWriter(bufw)
		gzw.Write([]byte(data.Encode()))
		gzw.Close()
		ir = bufw
	} else {
		ir = strings.NewReader(data.Encode())
	}

	return c.Post(rawurl, "application/x-www-form-urlencoded", ir)
}

func (c *Client) PostMultipart(rawurl string, data map[string][]string) (resp *http.Response, err error) {
	body, ct, err := multipart.Open(data)
	if err != nil {
		return
	}

	if c.useGzip {
		bufw := new(bytes.Buffer)
		gzw := gzip.NewWriter(bufw)
		gzw.Write(body.Bytes())
		gzw.Close()
		body = bufw
	}

	return c.Post(rawurl, ct, body)
}

func (c *Client) Put(rawurl string, bodyType string, body io.Reader) (*http.Response, error) {
	return c.doMethod("PUT", rawurl, bodyType, body)
}

func (c *Client) PutForm(rawurl string, data url.Values) (*http.Response, error) {
	var ir io.Reader
	if c.useGzip {
		bufw := new(bytes.Buffer)
		gzw := gzip.NewWriter(bufw)
		gzw.Write([]byte(data.Encode()))
		gzw.Close()
		ir = bufw
	} else {
		ir = strings.NewReader(data.Encode())
	}

	return c.Put(rawurl, "application/x-www-form-urlencoded", ir)
}

func (c *Client) Delete(rawurl string) (*http.Response, error) {
	req, err := http.NewRequest("DELETE", rawurl, nil)
	if err != nil {
		log.Debug("<HttpDelete> NewRequest error:", err)
		return nil, err
	}

	resp, respErr := c.Do(req)
	log.Debug("<HttpDelete> response:", resp, " response error:", respErr)
	return resp, respErr
}
