package stringutils

import "testing"

func TestSimpleString (test *testing.T) {
	PrintMessage("Testing Message")

	test.Fatalf("Deliberate Failure")
}