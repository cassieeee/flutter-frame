package multipart

import (
	"bytes"
	"golanger.com/log"
	"io"
	"mime/multipart"
	"os"
)

func Write(w *multipart.Writer, params map[string][]string) error {
	for key, param1 := range params {
		param := param1[0]
		if len(param) > 0 && param[0] == '@' {
			file := param[1:]
			fw, err := w.CreateFormFile(key, file)
			if err != nil {
				log.Println("CreateFormFile failed:", err)
				return err
			}
			fd, err := os.Open(file)
			if err != nil {
				log.Println("Open file failed:", err)
				return err
			} else {
				_, err = io.Copy(fw, fd)
				fd.Close()
				if err != nil {
					log.Println("Copy file failed:", err)
					return err
				}
			}
		} else {
			err := w.WriteField(key, param)
			if err != nil {
				return err
			}
		}
	}
	return nil
}

func Open(params map[string][]string) (*bytes.Buffer, string, error) {
	w1 := &bytes.Buffer{}
	w := multipart.NewWriter(w1)
	defer w.Close()

	return w1, w.FormDataContentType(), Write(w, params)
}
