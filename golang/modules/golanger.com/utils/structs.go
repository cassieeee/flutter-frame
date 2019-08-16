package utils

import (
	"fmt"
	"reflect"
	"strings"
)

type Struct struct {
	I interface{}
}

func (s Struct) GetTypeName() string {
	var typestr string
	typ := reflect.TypeOf(s.I)
	typestr = typ.String()

	lastDotIndex := strings.LastIndex(typestr, ".")
	if lastDotIndex != -1 {
		typestr = typestr[lastDotIndex+1:]
	}

	return typestr
}

func (s Struct) StructName() string {
	v := reflect.TypeOf(s.I)
	for v.Kind() == reflect.Ptr {
		v = v.Elem()
	}
	return v.Name()
}

// convert struct to map
// s must to be struct, can not be a pointer
func (s Struct) RawStructToMap(snakeCasedKey bool) M {
	v := reflect.ValueOf(s.I)
	for v.Kind() == reflect.Ptr {
		v = v.Elem()
	}
	if v.Kind() != reflect.Struct {
		panic(fmt.Sprintf("param s must be struct, but got %s", s.I))
	}

	m := M{}
	for i := 0; i < v.NumField(); i++ {
		vf := v.Field(i)
		if vf.CanInterface() {
			vtf := v.Type().Field(i)
			key := vtf.Name
			if snakeCasedKey {
				key = Strings(key).SnakeCasedName()
			} else {
				if vtf.Tag.Get("field") != "" {
					key = vtf.Tag.Get("field")
				} else if vtf.Tag.Get("json") != "" {
					key = vtf.Tag.Get("json")
				}
			}

			val := vf.Interface()
			if vf.Kind() == reflect.Struct {
				val = Struct{I: vf.Interface()}.RawStructToMap(snakeCasedKey)
			}

			m[key] = val
		}
	}

	return m
}

// convert struct to map
func (s Struct) StructToMap() M {
	return s.RawStructToMap(false)
}

// convert struct to map
// but struct's field name to snake cased map key
func (s Struct) StructToSnakeKeyMap() M {
	return s.RawStructToMap(true)
}
