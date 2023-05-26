#!/bin/bash
# installer for OnlyRAT
# created by : C0SM0

# staging
echo [*] Staging process...
mkdir ~/.OnlyRAT
cd ..
mv MK01-OnlyRAT/* ~/.OnlyRAT
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
echo "alias onlyrat=\"python3 $(pwd)/main.py\"" >> ~/.zshrc
echo [+] Completed

# clean up
echo [+] Installation Completed
echo "- please restart your terminal"
echo "- type 'onlyrat' to launch OnlyRat"
