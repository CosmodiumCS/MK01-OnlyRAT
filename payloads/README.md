# Payloads
This directory contains all of the payloads that our OnlyRAT will use on our target systems. Some files in here are used for the installation processes.

## stage1.cmd
Gets administrative permissions to properly install the RAT. It will add exclusion paths for the `Startup` and `Temp` directories so Defender doesn't give us any issues. After that it installs and runs our `stage2.cmd` file. It will finally delete itself to cover the rats traces.

## stage2.ps1
This file is the most important file in the installation process. It is the file that installs and sets up the RAT and it's dependencies.

It will first create a local admin account that we will use to modify the system as we see fit. It then creates a working directory in the `Temp` directory for us to store files the RAT relies on. 

It will then enable persistant SSH so we can always remotely access the computer with our administrative account. This will then download and run our `hide-user.reg` and `confirm-reg.vbs` and invoke them. Thia process will hide our administrative account. 

It will now install our `webcam.exe` and `confirm-web.vbs`. These two files set up our ability to take pictures through our target webcame. Once these are executed sucessfully, `stage2.ps1` will clean up, cover our tracks, and self delete.

## hide-user.reg
This is a registry file that hides our administrative user from the system log in page.

## confirm-reg.vbs
When installing the `hide-user.reg` file, we need to interact with some interactive windows. To bypass this, we use this vbs file to inject keystrokes and bypass the confirmations windows.

## update.sh
A file used by our `main.py` file in order to check for updates and update the OnlyRAT malware.

## keylogger.ps1
A powershell keylogger that can log the keystrokes that user is typing. It saves the logs to a `<username>.log` file. OnlyRAT has a module to grab the log file off of the computer and wipe it to remain unoticed.

## screenshot.ps1
Takes screenshots of target pc every minute. It saves it to an obfuscated directory within the users `Temp` directory. OnlyRAT has a module where we can grab these screenshots off of the computer and send them to our atacker pc.

## webcam.exe
A compiled C++ file that takes pictures of our target through their webcam. 

## confirm-cam.vbs
Because our `webcam.exe` doesn't have a license, we need to bypass windows popups from popping up everytime we run the file. So we inject some keystrokes with our `confirm-cam.vbs` to solve this issue.

## webcam.ps1
This file controlls the webcam workflow. Basically taking pictures through the targets webcam every minute. It also formats the images so they can be sent back to us.

## defender.ps1
The "butt fucker" of Windows Defender. Essentially disabling every concievable part of windows defender. OnlyRAT doesn't actually need to disable defender because it is currently not detectable by Anti-Virus software. But it is an optional payload the attacker can use for extra security or if they need to upload any additional malware. **However,** disabling defender could be a huge indicator of our presence. 
