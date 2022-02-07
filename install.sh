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
echo [+] Completed

# set up alias workflow
echo [*] Setting up alias...
echo "alias onlyrat=\"python3 $(pwd)/main.py\"" >> ~/.bashrc
echo [+] Completed

# clean up
echo [+] Installation Completed
echo "- please restart your terminal"
echo "- type 'onlyrat' launch OnlyRat"
