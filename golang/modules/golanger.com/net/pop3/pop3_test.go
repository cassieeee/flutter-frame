/*package pop3

import (
	"io/ioutil"
	"testing"
)

func TestPop3(t *testing.T) {
	client, err := DialTLS("pop3.163.com:995")
	//client, err := Dial("pop.163.com:110")
	if err != nil {
		t.Error("DialTLS error:", err)
		return
	}

	err = client.AuthBasic("setysgpfxds1@163.com", "65432qwer")
	if err != nil {
		t.Error("AuthBasic error:", err)
		return
	}

	err = client.Noop()
	if err != nil {
		t.Error("Noop error:", err)
		return
	}

	num, octs, err := client.Status()
	if err != nil {
		t.Error("Status error:", err)
		return
	}

	t.Log(num, octs)

	fds, err := client.ListAll()
	if err != nil {
		t.Error("ListAll error:", err)
		return
	}

	t.Log(fds)

	for i := 0; i < num; i++ {
		j, s, err := client.List(i + 1)
		if err != nil {
			t.Error("List error:", err)
			return
		}

		t.Log(j, s)
	}

	bts, err := client.Retrieve(num)
	if err != nil {
		t.Error("Retrieve error:", err)
		return
	}

	t.Log(string(bts))

	msg, err := client.ReadMessage(bts)
	if err != nil {
		t.Error("ReadMessage error:", err)
		return
	}

	t.Log(msg.Header)
	t.Log(msg.Body)
	body, err := ioutil.ReadAll(msg.Body)
	if err != nil {
		t.Error("ReadAll body error:", err)
		return
	}

	t.Log(string(body))
}
*/