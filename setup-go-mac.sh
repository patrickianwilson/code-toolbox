echo "Setting Up Workstation for Golang Development"


#Ensure HomeBrew is installed.  This is the package manager of choice for Mac OS
command -v brew >/dev/null 2>&1 || { echo >&2 "Homebrew is required for these setup scripts but it's not installed.  Aborting."; exit 1; }


#Is Go already installed?
command -v go >/dev/null 2>&1 || { echo >&2 "Installing Go from Homebrew"; brew install go --cross-compile-common; exit 1; }

#Sublime is the editor of choice for Golang programmers.
command -v subl >/dev/null 2>&1 || { echo >&2 "Sublime Text is Not Properly Installed, Please Install from: http://www.sublimetext.com"; echo "you must also link the 'subl' command to your path: sudo ln -s \"/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl\" /bin/subl"; read -p "Press [Enter] Once the Above is complete..."; echo "Install the golang plugin for Sublime Text 2 as documented here: https://github.com/DisposaBoy/GoSublime"; read -p "Press [Enter] Once the Above Plugin Is Installed"; }

curl https://codeload.github.com/patrickianwilson/template-golang-project/zip/master > temp.zip
unzip temp.zip
mv template-golang-project-master/* .
rm -r template-golang-project-master
rm temp.zip

chmod +x *.sh

export GOPATH=`pwd`

go get github.com/mailgun/godebug

echo "New GoLang Project Initialized Successfully!"






