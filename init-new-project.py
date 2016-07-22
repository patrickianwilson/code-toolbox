#!/usr/bin/env python
# TODO add this to the README.md file...
# A single project-init file that is cross platform and allows for language to be selected.
# The new project init file is conventions based.  The project init process is as follows:

# 1. Choose a language from the map of lang -> github template repo
# 2. Choose a flavor for that lang (from a sub map of flavor -> branch name)
# 3. wget the zip archive of that repo/branch and expand it in the current dir.
# 4. run ./project-init.sh (one time things)
# 5  run ./dev-setup.sh (will be run by the project gradle structure on every build).  This file will ensure the developer environment and tools are up to date.


import imp

# check if wget package is installed
try:
    imp.find_module('wget')
except ImportError:
    print("Package WGET is not installed.  Please run 'pip install wget' and run again")
    exit(2)

import wget
import zipfile
import os
import stat
import shutil
import subprocess

langs = {
    'java': 'template-java-project',
    'golang': 'template-golang-project',
    'cpp': 'template-c-cpp-project'
}

# each lang in langs must have an associated dictionary in the nested map.
flavorsMap = {
    'java': {'vanilla': 'master'},
    'golang': {'vanilla': 'master', 'web-app': 'web-app', 'web-service': 'web-service'},
    'cpp': {'vanilla': 'master'}

}


###HELPER FUNCTIONS###
def exitScript(retVal):
    exit(retVal)


# from http://stackoverflow.com/questions/1868714/how-do-i-copy-an-entire-directory-of-files-into-an-existing-directory-using-pyth
def copytree(src, dst, symlinks=False, ignore=None):
    for item in os.listdir(src):
        s = os.path.join(src, item)
        d = os.path.join(dst, item)
        if os.path.isdir(s):
            shutil.copytree(s, d, symlinks, ignore)
        else:
            shutil.copy2(s, d)


def execute_and_possibly_remove(file, alsoRemove=False):
    if os.path.isfile(file):
        st = os.stat(file)
        # make the file executable.
        os.chmod(file, st.st_mode | stat.S_IEXEC)
        result = subprocess.call("./{}".format(file), shell=True)
        if result == 0 and alsoRemove:
            os.remove(file)


##MAIN SCRIPT####
targetLang = raw_input('Please choose a language from [' + ", ".join(langs.keys()) + ']')

if not langs.has_key(targetLang):
    print "Language " + targetLang + " not found"
    exitScript(1)

targetFlavor = raw_input('Please choose a project \'flavor\' from [' + ", ".join(flavorsMap[targetLang].keys()) + ']')

if not flavorsMap.get(targetLang).has_key(targetFlavor):
    print "Language Flavor " + targetFlavor + " is not valid for language " + targetLang
    exitScript(2)

projectRepo = langs[targetLang]
projectBranch = flavorsMap[targetLang][targetFlavor]

zipFetchUrl = "https://github.com/patrickianwilson/{}/archive/{}.zip".format(projectRepo, projectBranch)

templateZipFile = wget.download(zipFetchUrl)
zFileHandle = zipfile.ZipFile(templateZipFile)
zFileHandle.extractall()

rootDirname = "{}-{}".format(projectRepo, projectBranch)

copytree(rootDirname, ".")
shutil.rmtree(rootDirname)

print("Template project initialization starting")

# if the project has an initial setup script (language/flavor specific)
execute_and_possibly_remove("project-init.sh", True)

# if the project has an developer setup script(language/flavor specific)
execute_and_possibly_remove("project-developer-setup.sh")
