#eventually this will be a gradle plugin/script.


export PROJECT=/Users/pwilson/Documents/go_workspaces/app_and_test_sample

export GOUNIT_DIR=$PROJECT/gounit
mkdir -p $GOUNIT_DIR/build/object
#build the dependencies 
go tool 6g -o $GOUNIT_DIR/build/object/gounit.6 $GOUNIT_DIR/src/main/go/gounit.go



export MAIN_DIR=$PROJECT/application
mkdir -p $MAIN_DIR/build/object
mkdir -p $MAIN_DIR/bin

#compile the package
go tool 6g -o $MAIN_DIR/build/object/stringutils.6 $MAIN_DIR/src/main/go/string/utils.go 

#run the tests - unify the pakcage source with the src test.
go tool 6g -o $MAIN_DIR/build/object/stringutils_test.6 -I $MAIN_DIR/build/object -I $GOUNIT_DIR/build/object $MAIN_DIR/src/test/go/string/util_test.go 
#link and run the tests
go tool 6l -o $MAIN_DIR/bin/stringutils_tests -L $MAIN_DIR/build/object -L $GOUNIT_DIR/build/object $MAIN_DIR/build/object/stringutils_test.6

go tool 6g -o $MAIN_DIR/build/object/main.6 -I $MAIN_DIR/build/object $MAIN_DIR/src/main/go/main/main.go 


go tool 6l -o $MAIN_DIR/bin/app -L $MAIN_DIR/build/object $MAIN_DIR/build/object/main.6 



#take away pattern:  use the -o compiler flag to specify the output module file
# use the -I compiler flag to specify the import path for partially compiled object files

#for the link step, use the -L flag to specify the directory that holds all the *.{6|8|5} files that need to be linked together.  Point the linker at the "main" execution package.