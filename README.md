# code-toolbox
This project is an attempt to provide quick setup scripts and frequently used code patterns for several prominent programming languages.  It uses the common 

```bash
python <(curl https://someaddress/script.sh)
```

paradigm to actually setup an environment and setup the missing tools for that language

There are two suggested setup steps...  
1. Make a python sandbox env (virutal env) (to safely pip install the dependency) or install pip packages globally
2. pip install wget (for global install - ```sudo python -m pip install wget```

 


```bash
python <(curl https://raw.githubusercontent.com/patrickianwilson/code-toolbox/master/init-new-project.py)
```

Simply create a new directory for your project, 'cd' into that directory and copy and paste one of the above bash commands into that directory.  The scripts are interactive and will walk you through the setup process.  In addition to creating a template project, the scripts will also detect if you workstation is missing critical development tools for that language.  For instance, if you attempt to create a new Android project but do not have the Android SDK installed.  The script will automatically install any missing tools and setup up your path appropriately.

Enjoy!


