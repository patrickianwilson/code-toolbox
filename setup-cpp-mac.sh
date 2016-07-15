#!/bin/bash

echo "Setting Up Workstation for C/C++ Development"

read -p "Please specify a template flavor (master): " branch

echo "Checking out \"$branch\""

if [ "$branch"="master" ] || [ "$branch"="future" ]; then
	curl https://codeload.github.com/patrickianwilson/template-c-cpp-project/zip/$branch > temp.zip
	unzip temp.zip
	mv template-c-cpp-project-$branch/* .
	rm -r template-c-cpp-project-$branch
	rm temp.zip

	chmod +x *.sh

	echo "Initializing Project Flavor"
	./project-init.sh
	rm project-init.sh


	echo "New C/C++ Project Initialized Successfully!"
else
	echo "Invalid Project Flavor - please choose either \"master\""
fi