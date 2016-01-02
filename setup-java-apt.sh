echo "Setting Up Workstation for Golang Development"


#Ensure HomeBrew is installed.  This is the package manager of choice for Mac OS
command -v apt-get >/dev/null 2>&1 || { echo >&2 "Aptitude is required for these setup scripts but it's not installed.  Aborting."; exit 1; }


#Is Go already installed?
command -v java >/dev/null 2>&1 || { 
	echo >&2 "Installing Java from Aptitude"
	sudo apt-add-repository ppa:webupd8team/java
	sudo apt-get update
	sudo apt-get install oracle-java8-installer

}



#Sublime is the editor of choice for Java and Scripting programmers.
command -v subl >/dev/null 2>&1 || { 
	echo >&2 "Installing Sublime Text 3."
	sudo add-apt-repository ppa:webupd8team/sublime-text-3
	sudo apt-get update
	sudo apt-get install sublime-text-installer

}

ROOT_PROJECT=`pwd`
#gradle is the build system of choice for java projects (including Android)
command -v gradle >/dev/null 2>&1 || {
	echo "Installing Latest Gradle"

	curl https://downloads.gradle.org/distributions/gradle-2.10-bin.zip > temp.zip
	unzip temp.zip
	sudo cp -r gradle-2.10 /opt/
	sudo chmod -R 755 /opt/gradle-2.10
	sudo rm -rf temp.zip gradle-2.10
	sudo ln -s /opt/gradle-2.10/bin/gradle /usr/bin/gradle
}

cd $ROOT_PROJECT

read -p "Please specify a template flavor (master [for vanilla], root-gradle-project or android): " branch

echo "Checking out \"$branch\""

if [ "$branch"="master" ] || [ "$branch"="root-gradle-project" ] || [ "$branch"="android" ]; then
	curl https://codeload.github.com/patrickianwilson/template-java-project/zip/$branch > temp.zip
	unzip temp.zip
	mv template-java-project-$branch/* .
	rm -r template-java-project-$branch
	rm temp.zip

	chmod +x *.sh

	echo "Initializing Project Flavor"
	./project-init.sh
	rm project-init.sh


	echo "New Java Project Initialized Successfully!"
else
	echo "Invalid Project Flavor - please choose either \"master\" (for vanilla), \"root-gradle-project\" or \"android\""
fi






