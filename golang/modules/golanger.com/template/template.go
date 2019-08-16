package template

import (
	"fmt"
	"golanger.com/log"
	"io"
	"io/ioutil"
	"path/filepath"
	"text/template"
	"text/template/parse"
)

type FuncMap map[string]interface{}

type Template struct {
	text *template.Template
	*nameSpace
}

func Must(t *Template, err error) *Template {
	if err != nil {
		log.Panic("<Must> Name: ", t.Name(), ", error:", err)
		return nil
	}

	return t
}

func Test(t *Template, err error) *Template {
	if err != nil {
		log.Error("<Test> Name: ", t.Name(), ", error:", err)
	}

	return t
}

func New(name string) *Template {
	tmpl := &Template{
		template.New(name),
		&nameSpace{
			tmpls: make(map[string]*Template),
		},
	}

	tmpl.nameSpace.Insert(name, tmpl)

	return tmpl
}

//修正标准库的parseFiles在解析文件的时候，如果不同路径，同名也会报错的bug
func parseFiles(t *Template, filenames ...string) (*Template, error) {
	if len(filenames) == 0 {
		// Not really a problem, but be consistent.
		return nil, fmt.Errorf("template: no files named in call to ParseFiles")
	}

	for _, filename := range filenames {
		b, err := ioutil.ReadFile(filename)
		if err != nil {
			return nil, err
		}

		s := string(b)
		name := filepath.Clean(filename)

		var tmpl *Template
		if t == nil {
			t = New(name)
		}

		if name == t.Name() {
			tmpl = t
		} else {
			tmpl = t.New(name)
		}

		_, err = tmpl.Parse(s)
		if err != nil {
			return nil, err
		}
	}

	return t, nil
}

func parseGlob(t *Template, pattern string) (*Template, error) {
	filenames, err := filepath.Glob(pattern)
	if err != nil {
		return nil, err
	}

	if len(filenames) == 0 {
		return nil, fmt.Errorf("template: pattern matches no files: %#q", pattern)
	}

	return parseFiles(t, filenames...)
}

func ParseFiles(filenames ...string) (*Template, error) {
	return parseFiles(nil, filenames...)
}

func ParseGlob(pattern string) (*Template, error) {
	return parseGlob(nil, pattern)
}

func (t *Template) AddParseTree(name string, tree *parse.Tree) (*Template, error) {
	text, err := t.text.AddParseTree(name, tree)
	if err != nil {
		return nil, err
	}

	t.nameSpace.mu.RLock()
	ret := &Template{
		text,
		t.nameSpace,
	}
	t.nameSpace.mu.RUnlock()

	t.nameSpace.Upsert(name, ret)
	return ret, nil
}

func (t *Template) Clone() (*Template, error) {
	textClone, err := t.text.Clone()
	if err != nil {
		return nil, err
	}

	ret := &Template{
		textClone,
		&nameSpace{
			tmpls: make(map[string]*Template),
		},
	}

	for _, x := range textClone.Templates() {
		name := x.Name()
		if _, ok := t.nameSpace.get(name); !ok {
			return nil, fmt.Errorf("html/template: cannot Clone %q after it has executed", t.Name())
		}

		if x.Tree != nil {
			x.Tree = &parse.Tree{
				Name: x.Tree.Name,
				Root: x.Tree.Root.CopyList(),
			}
		}

		t.nameSpace.mu.RLock()
		ret.nameSpace.Upsert(name, &Template{
			x,
			ret.nameSpace,
		})
		t.nameSpace.mu.RUnlock()
	}

	return ret, nil
}

func (t *Template) Delims(left, right string) *Template {
	t.text.Delims(left, right)
	return t
}

func (t *Template) Execute(wr io.Writer, data interface{}) (err error) {
	return t.text.Execute(wr, data)
}

func (t *Template) Lookup(name string) (tmpl *Template, err error) {
	tmpl, ok := t.nameSpace.get(name)
	if !ok {
		return nil, fmt.Errorf("template: %q is undefined", name)
	} else {
		t.nameSpace.mu.RLock()
		defer t.nameSpace.mu.RUnlock()
		if tmpl.text.Tree == nil || tmpl.text.Root == nil {
			return nil, fmt.Errorf("template: %q is an incomplete template", name)
		}

		if t.text.Lookup(name) == nil {
			log.Panic("template internal error: template escaping out of sync")
		}
	}

	return tmpl, err
}

func (t *Template) ExecuteTemplate(wr io.Writer, name string, data interface{}) error {
	tmpl, err := t.Lookup(name)
	if err != nil {
		return err
	}

	return tmpl.text.Execute(wr, data)
}

func (t *Template) Funcs(funcMap FuncMap) *Template {
	t.text.Funcs(template.FuncMap(funcMap))
	return t
}

func (t *Template) Name() string {
	return t.text.Name()
}

func (t *Template) New(name string) *Template {
	return t.new(name)
}

func (t *Template) new(name string) *Template {
	t.nameSpace.mu.RLock()
	tmpl := &Template{
		t.text.New(name),
		t.nameSpace,
	}
	t.nameSpace.mu.RUnlock()

	tmpl.nameSpace.Upsert(name, tmpl)
	return tmpl
}

func (t *Template) Templates() []*Template {
	ns := t.nameSpace
	// Return a slice so we don't expose the map.
	m := make([]*Template, 0, ns.Length())

	ns.mu.RLock()
	for _, v := range ns.tmpls {
		m = append(m, v)
	}
	ns.mu.RUnlock()

	return m
}

func (t *Template) Parse(src string) (*Template, error) {
	ret, err := t.text.Parse(src)
	if err != nil {
		return nil, err
	}

	// In general, all the named templates might have changed underfoot.
	// Regardless, some new ones may have been defined.
	// The template.Template set has been updated; update ours.
	for _, v := range ret.Templates() {
		name := v.Name()
		tmpl, ok := t.nameSpace.get(name)
		if !ok {
			tmpl = t.new(name).Funcs(extFunc)
		}

		tmpl.text = v
	}
	return t, nil
}

func (t *Template) ParseGlob(pattern string) (*Template, error) {
	return parseGlob(t, pattern)
}

func (t *Template) ParseFiles(filenames ...string) (*Template, error) {
	return parseFiles(t, filenames...)
}
