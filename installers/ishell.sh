#!/bin/bash
# onlyrat for ish shell
# created by : bluecosmo

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
apk update
apk add sshpass
apk add python3
echo [+] Completed

# set up alias workflow
echo [*] Setting up alias...
echo "alias onlyrat=\"python3 $(pwd)/main.py\"" >> ~/.bashrc
echo [+] Completed

# clean up
echo [+] Installation Completed
echo "- please restart your terminal"
echo "- in bash, type 'onlyrat' to launch OnlyRat"

