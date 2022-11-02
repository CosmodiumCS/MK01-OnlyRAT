# OnlyRAT [BETA]
> Blue Cosmo | 01/07/2022
---

```
                                                                     _;,
                                                 ,,=-,--,,__     _,-;:;;},,,_    
            _,oo,         Ll                 _,##&&&&$$&&$$$&-=;%%^%&;v:&& @ `=,_   
          ,oO" `0}        Ll              ,%#####&#>&&$$$$&$$$&,&'$$#`"%%;,,,*%^<}  
      _,--O;_,  0_        Ll            ,%%%%%&%-#&###$$"$$$$$*;&&$,#;%^*%$$^{,%;'
   ,cC'oO`'CC  ,OnnNNNNn, Ll  YY,      ,%#&%%$$$$%%%%%##&&^$%^%&&&$$'&#,-%%--"'
  ,CCCO"   `C ,0`Nn`  `Nn Ll   YY,    ,;;##&,$$$$$$$;,%%%&&%%%&&&&&&$$%%'
  {CC{       ,0' NN    NN Ll    Yy  yY';#&,#,$$$$$%%%%%%%%&%%%&&&&&&%%`
  CCC(     _o0   NN    NN Ll     YyyY ,;&##&###%%$$%&&%%%%#^%^&&&&&%{`
 ,OCC{    ,0C    NN    NN Ll      YY   ;#&&#####&%;%&&,%%%%#%=%%%&^%%               
,O`'"Cc_.o0cC    NN    NN Ll y,   YY   ;&&&^##&&&$%&&&%%%"`     `%%%%               
o0    _o0"` '`   NN    NN Ll  Yy,yYY  '^%%&VGh%%%%%&&"^%_,,       "%%%,_      _,.,_  
0o,_,oo0"        NN    NN Ll   `YyY`    ``'"lIG9ubHkg,,""''`        ""%%>_,;VyIG5lZ;,   
"00O"`                                          ``'``""UkFUIHlvdSdsbCBldm;"       `"WQ=,     
```

## [!!] DISCLAIMER
TLDR:
Please use securily and ethically :D

Feel free to use this RAT on any computer that you own or have permissions to test malicious code on. It's perfectly legal. But do not install this RAT on targets you don't have permission to test malware on. Not only is it illegal, but by doing so you are putting that computer at risk. Since the RAT needs to be able to remotely connect, it is enabling a persistence that other hackers on the network may target or even bruteforce. 

The purpose of this RAT is to teach members of the security community the basics of malware development, so do not use with malintent. Malware development is an essential skill that is often overlooked within the security world. By learning malware development, security researchers can both better understand how hackers think and develop malicious code, as well as learning to develop their own for security purposes. By making a single RAT that can hold all of the teachings in one form factor, it is much easier to connect the lessons.

## Overview:
OnlyRAT [Only Remote Access Tool] is the *only RAT* you'll ever need. This tool is an SSH [Secure SHell] RAT that is completely network oriented, making it virtually fileless. It is capable of remotely connecting to the target computer, remote file uploads and downloads, as well as code execution **all** through network commands and communicaiton.

It's advanced network capabilities make it difficult for standard antivirus and firewalls to detect. The RAT has a multitude of ways of how it can be installed on to a target pc, including batch file installation and the use of [Hak5](https://hak5.org) gear. Depending on how OnlyRAT is installed, you can have formated as a *from github* or *from vps* install.

*From GitHub* will install OnlyRAT from GitHub's raw data, allowing no user configuration. But the **connection can only be local** since there is no VPS to route traffic and forward ports from.

*From VPS* will install OnlyRAT utilizing a Virtual Private Server (VPS) or any computer accessible on the internet to route traffic to and from the target. Meaning with this installer, you can **access your target from anywhere**.

## Resources:
- [YouTube Video]()
- [YouTube Channel](https://youtube.com/cosmodiumcs)
- [Website](https://cosmodiumcs.com)
- [Article](https://www.cosmodiumcs.com/post/ssh-network-attacks-in-onlyrat)

## Requirements:
**Attacker PC:**
- Security Linux [Debian Based]
    - Kali Linux
    - Parrot OS
- Linux Terminal
- Python3
- SSH Tools
    - openssh-client
    - ssh-keygen
    - ssh-copy-id

**Target PC:**
- Windows 10 Home

## Installation:
**Target Installation:**
- The [installers](https://github.com/CosmodiumCS/OnlyRAT/tree/main/installers) folder contains all the ways we can install the RAT on to our target

**Attacker Installation:**
1. Install OnlyRAT by cloning this repository
```bash
git clone https://github.com/CosmodiumCS/OnlyRAT.git
```
2. Install dependencies for OnlyRAT
    - **YES**, the onlyRAT directory **is** supposed to disappear
    - restart terminal once installation is complete
```bash
cd OnlyRAT
bash install.sh
```

## Configuration File:
The configuration file `username.rat` is a file we obtain through our OnlyRAT [installers](https://github.com/CosmodiumCS/OnlyRAT/tree/main/installers). It saves information that OnlyRAT needs in order to connect back to our target computer. Having configuration files allows hackers to have a database of all the comprimised pc's they have access to.

If VPS install was used, download configuration by running:
```bash
onlyrat -d
# or
onlyrat --dfig
```

## Running OnlyRAT:
1. Run `onlyrat` in your terminal for help
```bash
onlyrat
#or
onlyrat -h
# or
onlyrat --help
```
2. Append configuraiton file to specify target
```bash
onlyrat bluecosmo.rat
```
3. For additional information, run:
```bash
onlyrat -m
# or
onlyrat --man
#or
onlyrat --manual
```

## How It Works:
OnlyRAT is a very simple yet complex peice of network oriented malware. To learn how it works and to possibly build up your malware skillset, I highly reccomend checking out [this](https://www.cosmodiumcs.com/post/ssh-network-attacks-in-onlyrat) article that I wrote about OnlyRAT.

## Connection Types:
OnlyRAT is capable of connecting to the target both locally and remotely [VPS Install required for remote connections]. OnlyRAT makes this change easy via the following...

**Switch to Local Connection:**
To switch to a local connection, run:
```bash
onlyrat <username>.rat
set connection local
```

**Switch to Remote Connection:**
To switch to a remote connection, run:
```bash
onlyrat <username>.rat
set connection remote
```

## Updating OnlyRAT:
The CosmodiumCS Team will continuously push out updates to OnlyRAT. To prevent users from continuously having to reinstall OnlyRAT themselves. We have autmated the update process.

1. To check current version, run:
```bash
onlyrat -v
# or
onlyrat --version
```
2. To update, run:
```bash
onlyrat -u
# or
onlyrat --update
```
    - this will automatically check for the latest version and run update

## Uninstall OnlyRAT:
To uninstall OnlyRAT from your **atacker computer**, run:
```bash
onlyrat -r
# or
onlyrat --remove
# or
onlyrat --uninstall
```

## OnlyRAT Killswitch:
To uninstall OnlyRAT from your **target computer**, run:
```bash
onlyrat <username>.rat
killswitch
```

## Payloads:
```
[+] Command and Control:
    [orconsole] -------------- Remote Console
    [fix orconsole] ---------- Fix Remote Console
    [upload] ----------------- Uplowebhooks.logart Target PC
    [set connection local] --- Sets Connection to Local
    [set connection remote] -- Sets Connection to Remote
    [restart] ---------------- Restart Target PC
    [shutdown] --------------- Shutdown Target PC
    [killswitch] ------------- Removes OnlyRAT From Target

[+] Options:
    [help] ------------------- Help Menu
    [man] -------------------- Onlyrat Manual
    [config] ----------------- Display RAT File
    [version] ---------------- Version Number
    [update] ----------------- Update OnlyRAT
    [uninstall] -------------- Uninstall OnlyRAT
    [quit] ------------------- Quit
```
