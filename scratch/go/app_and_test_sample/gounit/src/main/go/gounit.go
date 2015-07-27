package gounit

import (
	"fmt"
	"reflect"
	"strings"
)

/*
this is the main object that all test methods will hang off of.
*/

type Tester interface {
} //marker interface


func Run(test Tester) {
	
	testType := reflect.TypeOf(test)

	for i := 0; i < testType.NumMethod(); i++ {
		method := testType.Method(i);

		if strings.HasPrefix(method.Name, "Test") {
			method.Call([]reflect.Value{})
		}
		fmt.Printf("Found Method: %s\n", method.Name)
	}
	fmt.Printf("running test!\n")



}



