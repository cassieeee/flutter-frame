package mapping

import (
	"fmt"
	"sync"
)

type Mapping struct {
	*mapping
}

type mapping struct {
	items map[string]interface{}
	mu    sync.RWMutex
}

func (m *mapping) Set(k string, x interface{}) {
	m.mu.Lock()
	m.items[k] = x
	m.mu.Unlock()
}

func (m *mapping) set(k string, x interface{}) {
	m.items[k] = x
}

func (m *mapping) Add(k string, x interface{}) error {
	m.mu.Lock()
	_, found := m.get(k)
	if found {
		m.mu.Unlock()
		return fmt.Errorf("Item %s already exists", k)
	}
	m.set(k, x)
	m.mu.Unlock()
	return nil
}

func (m *mapping) Replace(k string, x interface{}) error {
	m.mu.Lock()
	_, found := m.get(k)
	if !found {
		m.mu.Unlock()
		return fmt.Errorf("Item %s doesn't exist", k)
	}
	m.set(k, x)
	m.mu.Unlock()
	return nil
}

func (m *mapping) Get(k string) (interface{}, bool) {
	m.mu.RLock()
	item, found := m.items[k]
	if !found {
		m.mu.RUnlock()
		return nil, false
	}
	m.mu.RUnlock()
	return item, true
}

func (m *mapping) get(k string) (interface{}, bool) {
	item, found := m.items[k]
	if !found {
		return nil, false
	}
	return item, true
}

func (m *mapping) Delete(k string) (interface{}, bool) {
	m.mu.Lock()
	defer m.mu.Unlock()
	return m.delete(k)
}

func (m *mapping) delete(k string) (interface{}, bool) {
	if v, found := m.items[k]; found {
		delete(m.items, k)
		return v, true
	}

	return nil, false
}

func (m *mapping) Interfaces() map[string]interface{} {
	m.mu.RLock()
	defer m.mu.RUnlock()
	mp := make(map[string]interface{}, len(m.items))
	for k, v := range m.items {
		mp[k] = v
	}
	return mp
}

func (m *mapping) ItemCount() int {
	m.mu.RLock()
	n := len(m.items)
	m.mu.RUnlock()
	return n
}

func (m *mapping) Flush() {
	m.mu.Lock()
	m.items = map[string]interface{}{}
	m.mu.Unlock()
}

func newMapping(mp map[string]interface{}) *mapping {
	m := &mapping{
		items: mp,
	}
	return m
}

func New() *Mapping {
	items := make(map[string]interface{})
	m := newMapping(items)
	return &Mapping{m}
}
