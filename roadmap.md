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
- [x] keylogger
	- backspace detection
- [x] screenshots
    - delete screenshots off of target computer
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

ssh-keygen -f "/home/bluecosmo/.ssh/known_hosts" -R "192.168.1.50"