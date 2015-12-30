echo "Setting Up Workstation for Golang Development"


#Ensure HomeBrew is installed.  This is the package manager of choice for Mac OS
command -v apt-get >/dev/null 2>&1 || { echo >&2 "Aptitude is required for these setup scripts but it's not installed.  Aborting."; exit 1; }


#Is Go already installed?
command -v go >/dev/null 2>&1 || { echo >&2 "Installing Go from Aptitude";sudo apt-get install golang; exit 1; }


#install gvm
command -v gvm >/dev/null 2>&1 || { echo >&2 "Installing GVM for better management of Go Versions" 
	sudo apt-get install bison
	curl https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash
	source /home/pwilson/.gvm/scripts/gvm

	#create the compile directory
	gvm install go1.4
	gvm use go1.4  #needed as go1.5 needs to be compiled with go1.4.
	gvm install go1.5
	gvm use go1.5
}




#Sublime is the editor of choice for Golang programmers.
command -v subl >/dev/null 2>&1 || { 
	echo >&2 "Installing Sublime Text 3."
	sudo add-apt-repository ppa:webupd8team/sublime-text-3
	sudo apt-get update
	sudo apt-get install sublime-text-installer

	echo "Install the golang plugin for Sublime Text 3 as documented here: https://github.com/DisposaBoy/GoSublime"
	read -p "Press [Enter] Once the Above Plugin Is Installed"; 
}

read -p "Please specify a template flavor (master, web-service or web-app): " branch

echo "Checking out \"$branch\""

if [ "$branch"="master" ] || [ "$branch"="web-service" ] || [ "$branch"="web-app" ]; then
	curl https://codeload.github.com/patrickianwilson/template-golang-project/zip/$branch > temp.zip
	unzip temp.zip
	mv template-golang-project-$branch/* .
	rm -r template-golang-project-$branch
	rm temp.zip

	chmod +x *.sh

	export GOPATH=`pwd`

	echo "Initializing Project Flavor"
	./project-init.sh
	rm project-init.sh


	echo "New GoLang Project Initialized Successfully!"
else
	echo "Invalid Project Flavor - please choose either \"master\", \"web-service\" or \"web-application\""
fi


command -v goapp >/dev/null 2>&1 || {
	#should we install the app engine SDK?
	read -p "Install the App Engine SDK for Go Development? [Yes]/No" installGaeSDK
	if [ "$installGaeSDK"="No" ]; then
		mkdir -p ~/.appengine
		curl "https://storage.googleapis.com/appengine-sdks/featured/go_appengine_sdk_linux_amd64-1.9.30.zip" > ~/.appengine/gaeSDK.zip
		cd ~/.appengine
		unzip gaeSDK.zip
		
		#add the go_appengine binaries to the project path.
		echo "Add the following to your bash profile file (either ~/.profile or ~/.bash_profile) and source it. "
		echo 'export PATH=$PATH:~/.appengine/gaeSDK'
		read -p "Is the path updated and sourced?" cont
		echo "App Engine SDK Setup Complete!"
	fi

}






