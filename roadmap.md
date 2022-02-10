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
- [x] keylogger
	- backspace detection
- [x] screenshots
- [x] exfiltration
	- scp
- [x] file upload
- [ ] reconnaissance scan
	- web history
	- bookmarks
- [ ] escalation
	- wifi credentials
	- windows account reset
	- fake windows login
	- web credentials
		- generate wordlist for ssh bruteforce on main user
- [ ] destroy defender
	- firewall
- [ ] webcam capture
- [ ] killswitch
- [ ] advanced features
	- vm detection
	- port forwarding
	- worm
		- vbs special folders?
	- exploit for non priv users

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