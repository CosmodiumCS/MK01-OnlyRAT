#!/bin/bash
# installer for OnlyRAT
# created by : C0SM0

# staging
echo [*] Staging process...
mkdir ~/.MK01-OnlyRAT
cd ..
mv MK01-OnlyRAT/* ~/.MK01-OnlyRAT
rm -rf MK01-OnlyRAT
cd ~/.MK01-OnlyRAT
echo [+] Completed

#  get tools
echo [*] Installing tools...
sudo apt update
sudo apt-get install sshpass
sudo apt-get install python3
echo [+] Completed

# install to PATH
echo [*] Installing to /usr/local/bin...
    # Create a wrapper file in /usr/local/bin to call main.py
sudo touch /usr/local/bin/onlyrat
echo -e "#!/bin/bash\npython3 ~/.MK01-OnlyRAT/main.py \"\$@\"" | sudo tee /usr/local/bin/onlyrat
echo [+] Completed

# clean up
echo [+] Installation Completed
echo "- type 'onlyrat' to launch OnlyRat"
