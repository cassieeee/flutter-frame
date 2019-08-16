package http

import (
	"bytes"
	"encoding/gob"
)

func GobEncode(obj interface{}) ([]byte, error) {
	buf := bytes.NewBuffer(nil)
	enc := gob.NewEncoder(buf)
	err := enc.Encode(obj)
	if err != nil {
		return []byte(""), err
	}
	return buf.Bytes(), nil
}

func GobDecode(encoded []byte, i interface{}) error {
	buf := bytes.NewBuffer(encoded)
	dec := gob.NewDecoder(buf)
	return dec.Decode(i)
}
