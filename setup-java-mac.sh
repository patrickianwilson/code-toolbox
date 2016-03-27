echo "Setting Up Workstation for Golang Development"


#Ensure HomeBrew is installed.  This is the package manager of choice for Mac OS
command -v brew >/dev/null 2>&1 || { 
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}


#Is Java already installed?
command -v java >/dev/null 2>&1 || { 
	echo >&2 "Installing Java from Home Brew"
	brew update
	brew cask install java
	brew install jenv
}



#Sublime is the editor of choice for Golang programmers.
command -v subl >/dev/null 2>&1 || { 
	brew install caskroom/cask/brew-cask
	brew tap caskroom/versions
	brew cask install sublime-text3

	echo "you must also link the 'subl' command to your path: sudo ln -s \"/Applications/Sublime Text 3.app/Contents/SharedSupport/bin/subl\" /usr/local/bin/subl"; read -p "Press [Enter] Once the Above is complete..."; echo "Install the golang plugin for Sublime Text 2 as documented here: https://github.com/DisposaBoy/GoSublime"; read -p "Press [Enter] Once the Above Plugin Is Installed"; 
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
	sudo ln -s /opt/gradle-2.10/bin/gradle /usr/local/bin/gradle
}

cd $ROOT_PROJECT

read -p "Please specify a template flavor (master [for vanilla], root-gradle-project, swt-app, or android): " branch

echo "Checking out \"$branch\""

if [ "$branch"="master" ] || [ "$branch"="root-gradle-project" ] || [ "$branch"="android" ] || [ "$branch"="swt-app" ]; then
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






