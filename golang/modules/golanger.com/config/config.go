package config

import (
	"bytes"
	"encoding/json"
	"golanger.com/log"
	"io/ioutil"
	"os"
	"path/filepath"
	"regexp"
	"strings"
	"sync"
)

var (
	mu          sync.RWMutex
	ignoreFirst byte           = '.'
	regexpNote  *regexp.Regexp = regexp.MustCompile(`#.*`)
)

type Config struct {
	dataType string
	data     []byte
	target   string
	files    []string
}

func format(configPath string) []byte {
	data, err := ioutil.ReadFile(configPath)
	if err != nil {
		log.Fatal("<format> error: ", err)
	}

	return []byte(os.ExpandEnv(string(bytes.TrimSpace(regexpNote.ReplaceAll(data, []byte(``))))))
}

func readFiles(files ...string) []byte {
	lfs := len(files)
	chContent := make(chan []byte, lfs)

	for _, file := range files {
		go func(chContent chan []byte, configPath string) {
			chContent <- format(configPath)
		}(chContent, file)
	}

	bytess := make([][]byte, 0, lfs)

	for i := 1; i <= lfs; i++ {
		content := <-chContent

		if len(content) != 0 {
			bytess = append(bytess, content)
		}
	}

	buf := bytes.NewBufferString(`{`)
	buf.Write(bytes.Join(bytess, []byte(`,`)))
	buf.WriteString(`}`)

	var contentBuf bytes.Buffer
	err := json.Compact(&contentBuf, buf.Bytes())
	if err != nil {
		log.Debug("<readFiles> jsonData: ", buf.String())
		log.Fatal("<readFiles> error: ", err)
	}

	return contentBuf.Bytes()
}

func loadFiles(files ...string) *Config {
	filestmp := make([]string, 0, len(files))

	for _, file := range files {
		fileName := filepath.Base(file)
		if fileName[0] == ignoreFirst {
			continue
		}

		filestmp = append(filestmp, file)
	}

	return &Config{
		data:  readFiles(filestmp...),
		files: filestmp,
	}
}

func Data(data string) *Config {
	data = `{` + data + `}`
	var buf bytes.Buffer
	err := json.Compact(&buf, []byte(data))
	if err != nil {
		log.Debug("<Data> jsonData: ", data)
		log.Fatal("<Data> error: ", err)
	}

	return &Config{
		dataType: "data",
		data:     buf.Bytes(),
	}
}

func Files(files ...string) *Config {
	conf := loadFiles(files...)

	mu.Lock()
	conf.dataType = "files"
	conf.target = strings.Join(conf.files, ",")
	mu.Unlock()

	return conf
}

func Glob(pattern string) *Config {
	files, err := filepath.Glob(pattern)
	if err != nil {
		log.Fatal("<Glob> error: ", err)
	}

	conf := loadFiles(files...)

	mu.Lock()
	conf.dataType = "glob"
	conf.target = pattern
	mu.Unlock()

	return conf
}

func Dir(configDir string) *Config {
	configDir = filepath.Clean(configDir)
	fis, err := ioutil.ReadDir(configDir)
	if err != nil {
		log.Fatal("<Dir> error: ", err)
	}

	var files []string
	for _, fi := range fis {
		fileName := fi.Name()
		if fi.IsDir() || fileName[0] == ignoreFirst {
			continue
		}

		files = append(files, filepath.Join(configDir, fileName))
	}

	conf := loadFiles(files...)
	mu.Lock()
	conf.dataType = "directory"
	conf.target = configDir
	mu.Unlock()

	return conf
}

func (c *Config) Load(i interface{}) *Config {
	mu.RLock()
	data := c.data
	mu.RUnlock()

	err := json.Unmarshal(data, i)
	if err != nil {
		log.Debug("<Config.Load> jsonData: ", c.String())
		log.Fatal("<Config.Load> error: ", err)
	}

	return c
}

func (c *Config) indent() *bytes.Buffer {
	mu.RLock()
	data := c.data
	mu.RUnlock()

	buf := bytes.NewBuffer(nil)
	json.Indent(buf, data, "", "\t")
	return buf
}

func (c *Config) Bytes() []byte {
	return c.indent().Bytes()
}

func (c *Config) String() string {
	return c.indent().String()
}

func (c *Config) Target() string {
	mu.RLock()
	defer mu.RUnlock()

	return c.target
}
