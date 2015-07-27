package main

import (
	"gounit"
	"stringutils"
)

type MyTest struct {} 

func (test *MyTest) TestSimpleString () {
	stringutils.PrintMessage("Testing Message")
}


/**
main test entry point
*/
func main() {

	test := MyTest {}

	gounit.Run(&test)
}