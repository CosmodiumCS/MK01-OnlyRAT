# Payloads
This directory contains all of the payloads that our OnlyRAT will use on our target systems. Some files in here are used for the installation processes.

# stage1.cmd
Gets administrative permissions to properly install the RAT. It will add exclusion paths for the `Startup` and `Temp` directories so Defender doesn't give us any issues. After that it installs and runs our `stage2.cmd` file. It will finally delete itself to cover the rats traces.

# stage2.ps1
This file is the most important file in the installation process. It is the file that installs and sets up the RAT and it's dependencies.

It will first create a local admin account that we will use to modify the system as we see fit. It then creates a working directory in the `Temp` directory for us to store files the RAT relies on. 

It will then enable persistant SSH so we can always remotely access the computer with our administrative account. This will then download and run our `hide-user.reg` and `confirm-reg.vbs` and invoke them. After that it hides our administrative account and self deletes.

# hide-user.reg
This is a registry file that hides our administrative user from the system log in page.

# confirm-reg.vbs
When installing the `hide-user.reg` file, we need to interact with some interactive windows. To bypass this, we use this vbs file to inject keystrokes and bypass the confirmations windows.

# update.sh
A file used by our `main.py` file in order to check for updates and update the OnlyRAT malware.

# keylogger.ps1
A powershell keylogger that can log the keystrokes that user is typing.

# schedule.ps1
This runs the keylogger on an hourly basis to ensure we can receive

# controller.cmd