package template

import (
	"strconv"
	"strings"
)

func operator(op string, xs ...interface{}) interface{} {
	//类型处理函数定义--------------------------------------------------
	opInt := func(op string, ifs []int) interface{} {
		var i interface{}
		switch op {
		case "+":
			sum := ifs[0]
			for _, x := range ifs[1:] {
				sum += x
			}

			i = sum
		case "-":
			sum := ifs[0]
			for _, x := range ifs[1:] {
				sum -= x
			}

			i = sum
		case "*":
			sum := ifs[0]
			for _, x := range ifs[1:] {
				sum *= x
			}

			i = sum
		case "/":
			sum := ifs[0]
			for _, x := range ifs[1:] {
				sum /= x
			}

			i = sum
		case "%":
			i = float64(int64(ifs[0]) % int64(ifs[1]))
		case "==":
			i = ifs[0] == ifs[1]
		case "!=":
			i = ifs[0] != ifs[1]
		case ">":
			i = ifs[0] > ifs[1]
		case ">=":
			i = ifs[0] >= ifs[1]
		case "<":
			i = ifs[0] < ifs[1]
		case "<=":
			i = ifs[0] <= ifs[1]
		}
		return i
	}

	opInt32 := func(op string, ifs []int32) interface{} {
		var i interface{}
		switch op {
		case "+":
			sum := ifs[0]
			for _, x := range ifs[1:] {
				sum += x
			}

			i = sum
		case "-":
			sum := ifs[0]
			for _, x := range ifs[1:] {
				sum -= x
			}

			i = sum
		case "*":
			sum := ifs[0]
			for _, x := range ifs[1:] {
				sum *= x
			}

			i = sum
		case "/":
			sum := ifs[0]
			for _, x := range ifs[1:] {
				sum /= x
			}

			i = sum
		case "%":
			i = float64(int64(ifs[0]) % int64(ifs[1]))
		case "==":
			i = ifs[0] == ifs[1]
		case "!=":
			i = ifs[0] != ifs[1]
		case ">":
			i = ifs[0] > ifs[1]
		case ">=":
			i = ifs[0] >= ifs[1]
		case "<":
			i = ifs[0] < ifs[1]
		case "<=":
			i = ifs[0] <= ifs[1]
		}
		return i
	}

	opInt64 := func(op string, ifs []int64) interface{} {
		var i interface{}
		switch op {
		case "+":
			sum := ifs[0]
			for _, x := range ifs[1:] {
				sum += x
			}

			i = sum
		case "-":
			sum := ifs[0]
			for _, x := range ifs[1:] {
				sum -= x
			}

			i = sum
		case "*":
			sum := ifs[0]
			for _, x := range ifs[1:] {
				sum *= x
			}

			i = sum
		case "/":
			sum := ifs[0]
			for _, x := range ifs[1:] {
				sum /= x
			}

			i = sum
		case "%":
			i = float64(int64(ifs[0]) % int64(ifs[1]))
		case "==":
			i = ifs[0] == ifs[1]
		case "!=":
			i = ifs[0] != ifs[1]
		case ">":
			i = ifs[0] > ifs[1]
		case ">=":
			i = ifs[0] >= ifs[1]
		case "<":
			i = ifs[0] < ifs[1]
		case "<=":
			i = ifs[0] <= ifs[1]
		}
		return i
	}

	opFloat32 := func(op string, ifs []float32) interface{} {
		var i interface{}
		switch op {
		case "+":
			sum := ifs[0]
			for _, x := range ifs[1:] {
				sum += x
			}

			i = sum
		case "-":
			sum := ifs[0]
			for _, x := range ifs[1:] {
				sum -= x
			}

			i = sum
		case "*":
			sum := ifs[0]
			for _, x := range ifs[1:] {
				sum *= x
			}

			i = sum
		case "/":
			sum := ifs[0]
			for _, x := range ifs[1:] {
				sum /= x
			}

			i = sum
		case "%":
			i = float64(int64(ifs[0]) % int64(ifs[1]))
		case "==":
			i = ifs[0] == ifs[1]
		case "!=":
			i = ifs[0] != ifs[1]
		case ">":
			i = ifs[0] > ifs[1]
		case ">=":
			i = ifs[0] >= ifs[1]
		case "<":
			i = ifs[0] < ifs[1]
		case "<=":
			i = ifs[0] <= ifs[1]
		}
		return i
	}

	opFloat64 := func(op string, ifs []float64) interface{} {
		var i interface{}
		switch op {
		case "+":
			sum := ifs[0]
			for _, x := range ifs[1:] {
				sum += x
			}

			i = sum
		case "-":
			sum := ifs[0]
			for _, x := range ifs[1:] {
				sum -= x
			}

			i = sum
		case "*":
			sum := ifs[0]
			for _, x := range ifs[1:] {
				sum *= x
			}

			i = sum
		case "/":
			sum := ifs[0]
			for _, x := range ifs[1:] {
				sum /= x
			}

			i = sum
		case "%":
			i = float64(int64(ifs[0]) % int64(ifs[1]))
		case "==":
			i = ifs[0] == ifs[1]
		case "!=":
			i = ifs[0] != ifs[1]
		case ">":
			i = ifs[0] > ifs[1]
		case ">=":
			i = ifs[0] >= ifs[1]
		case "<":
			i = ifs[0] < ifs[1]
		case "<=":
			i = ifs[0] <= ifs[1]
		}
		return i
	}

	opString := func(op string, ifs []string) interface{} {
		var i interface{}
		switch op {
		case "+":
			s := ifs[0]
			for _, v := range ifs[1:] {
				s += v
			}
			i = s
		case "-":
			s := ifs[0]
			for _, v := range ifs[1:] {
				s = strings.Replace(s, v, "", -1)
			}
			i = s
		case "*":
			count, err := strconv.Atoi(ifs[1])
			if err != nil {
				i = ifs[0]
			}
			i = strings.Repeat(ifs[0], count)
		case "/":
			s := ifs[0]
			i = strings.Split(s, ifs[1])
		case "==":
			i = ifs[0] == ifs[1]
		case "!=":
			i = ifs[0] != ifs[1]
		case ">":
			i = ifs[0] > ifs[1]
		case ">=":
			i = ifs[0] >= ifs[1]
		case "<":
			i = ifs[0] < ifs[1]
		case "<=":
			i = ifs[0] <= ifs[1]
		default:
			i = nil
		}
		return i
	}
	//类型处理函数定义--------------------------------------------------

	l := len(xs)
	if l < 1 {
		return 0
	}
	var vi interface{}
	switch xs[0].(type) {
	case int:
		is := []int{xs[0].(int)}
		for i := 1; i < l; i++ {
			switch xs[i].(type) {
			case int:
				is = append(is, xs[i].(int))
			case int32:
				is = append(is, int(xs[i].(int32)))
			case float32:
				is = append(is, int(xs[i].(float32)))
			case float64:
				is = append(is, int(xs[i].(float64)))
			case int64:
				is = append(is, int(xs[i].(int64)))
			case string:
				v, err := strconv.ParseInt(xs[i].(string), 10, 64)
				if err != nil {
					v = 0
				}
				is = append(is, int(v))
			}
		}
		vi = is
	case int32:

		is := []int32{xs[0].(int32)}
		for i := 1; i < l; i++ {
			switch xs[i].(type) {
			case int:
				is = append(is, int32(xs[i].(int)))
			case int32:
				is = append(is, xs[i].(int32))
			case float32:
				is = append(is, int32(xs[i].(float32)))
			case float64:
				is = append(is, int32(xs[i].(float64)))
			case int64:
				is = append(is, int32(xs[i].(int64)))
			case string:
				v, err := strconv.ParseInt(xs[i].(string), 10, 64)
				if err != nil {
					v = 0
				}
				is = append(is, int32(v))
			}
		}
		vi = is
	case float32:
		is := []float32{xs[0].(float32)}
		for i := 1; i < l; i++ {
			switch xs[i].(type) {
			case int:
				is = append(is, float32(xs[i].(int)))
			case int32:
				is = append(is, float32(xs[i].(int32)))
			case float32:
				is = append(is, xs[i].(float32))
			case float64:
				is = append(is, float32(xs[i].(float64)))
			case int64:
				is = append(is, float32(xs[i].(int64)))
			case string:
				v, err := strconv.ParseFloat(xs[i].(string), 64)
				if err != nil {
					v = 0
				}
				is = append(is, float32(v))
			}
		}
		vi = is
	case float64:
		is := []float64{xs[0].(float64)}
		for i := 1; i < l; i++ {
			switch xs[i].(type) {
			case int:
				is = append(is, float64(xs[i].(int)))
			case int32:
				is = append(is, float64(xs[i].(int32)))
			case float32:
				is = append(is, float64(xs[i].(float32)))
			case float64:
				is = append(is, xs[i].(float64))
			case int64:
				is = append(is, float64(xs[i].(int64)))
			}
		}
		vi = is
	case int64:
		is := []int64{xs[0].(int64)}
		for i := 1; i < l; i++ {
			switch xs[i].(type) {
			case int32:
				is = append(is, int64(xs[i].(int32)))
			case float32:
				is = append(is, int64(xs[i].(float32)))
			case float64:
				is = append(is, int64(xs[i].(float64)))
			case int:
				is = append(is, int64(xs[i].(int)))
			case int64:
				is = append(is, xs[i].(int64))
			case string:
				v, err := strconv.ParseInt(xs[i].(string), 10, 64)
				if err != nil {
					v = 0
				}
				is = append(is, v)
			}
		}
		vi = is
	case string:
		is := []string{xs[0].(string)}
		for i := 1; i < l; i++ {
			switch xs[i].(type) {
			case int32:
				s := strconv.FormatInt(int64(xs[i].(int32)), 10)
				is = append(is, s)
			case float32:
				s := strconv.FormatFloat(float64(xs[i].(float32)), 'G', 4, 64)
				is = append(is, s)
			case float64:
				s := strconv.FormatFloat(float64(xs[i].(float64)), 'G', 4, 64)
				is = append(is, s)
			case int:
				s := strconv.FormatInt(int64(xs[i].(int)), 10)
				is = append(is, s)
			case int64:
				s := strconv.FormatInt(xs[i].(int64), 10)
				is = append(is, s)
			case string:
				is = append(is, xs[i].(string))
			}
		}
		vi = is
	}
	var i interface{}
	switch ifs := vi.(type) {
	case []int:
		i = opInt(op, ifs)
	case []int32:
		i = opInt32(op, ifs)
	case []int64:
		i = opInt64(op, ifs)
	case []float32:
		i = opFloat32(op, ifs)
	case []float64:
		i = opFloat64(op, ifs)
	case []string:
		i = opString(op, ifs)
	}
	return i
}
