# Modules
Help for all of the modules in OnlyRAT

## Command and Control:

### orconsole
Since we have persistent ssh on our target computer, we can use `orconsole` [OnlyRAT Console] to remotely access target in a command prompt. For linux syntax, type `powershell` in the orconsole.

### fix console
Because we are using ssh, we may need to add our target to our known hosts. So we can run `fix console` as a method to add it to our known hosts. That way we can use `orconsole` with ease.

### upload
The `uplaod` command allows us to remotely upload files to our target computer via scp.

### downlaod
The `download` command allows us to remotely download files off of our target computer via scp. This can also be reffered to as our `exfiltrate` module.

### restart
We can use `restart` to remotely restart the target computer. The reason why we have need this capability is to execute our malware initiated by the `startup` directory. Most modules will ask you to restart the target computer once malware has beento installed in order to execute it. It is suggested that you install the modules you think you will need and then restart the target computer [in order to avoid suspicion of your presence]

### shutdown
We can use the `shutdown` command to remotely shutdown the target computer.

### killswitch
The `killswitch` command removes OnlyRAT and its persisetnce off of our target computer. Removing our malware in the `startup` and `temp` directory.

## Reconnaissance:

### install keylogger
The command `install keylogger` will remotely install our powershell keylogger on to the target computer. This program will allow us to keep a log of everything the user types on their keyboard. All logs are saved to a `<username>.log` file within the `temp` directory. We need to restart the target computer in order to execute the keylogger.

### install screencapture
The `install screencapture` command will install our program that will a screenshot of the users desktop every minute. We need to restart the target computer in order to execute the screencapture.

### install webcam
The `install webcam` command will install our webcam highjacking malware on to our target computer. This malware [when executed] will take a picture of the user through their webcam every minute. Please note that the light indicator on their webcam may flash when the photos are being taken. We need to restart the target computer in order to execute the webcam.

### grab keylogs
The `grag keylogs` command will grab the keylogs off of the target computer and into the attacker's `Downloads` folder. It will also wipe the logs off of the target computer so the file doesn't grow too large and raise suspicion of our presence.

### grab screenshots
The `grab screenshots` command will grab screenshots from our screencapture. It will save it to the attacker's `Downloads` folder and wipe the images off of the target computer to avoid suspicion.

### grab webcam
The command `grab webcam` will grab the photos that from that the attacker has taken through their webcam. The photos will be moved to the attacker's `Downloads` folder. The photos on the targets computer are removed to avoid suspicion of our presence.

## Options:

### help
Displays the in terminal help menu for Onlyrat. Basic instructions to users started with OnlyRAT

### man
Dislplays the OnlyRAT `manual` page you are viewing currently. A more descriptive help menu for further instructions on the OnlyRAT malware.

### config
Displays and formats the information from the configuration file. 

### version
Displays the version number of the OnlyRAT malware installed on the attackers computer.

### update
Update OnlyRAT to the latest version.

### uninstall
`remove` OnlyRAT off of your attacker computer. Note, this **does not remove OnlyRAT off of your target computer**. Please use `killswitch` to remove OnlyRAT off of the target computer.

### quit
`quit` or `exit` the OnlyRAT shellscript.
