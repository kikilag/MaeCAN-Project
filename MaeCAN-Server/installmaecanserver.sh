#! /bin/bash

sudo su
echo 'Setting up Node lts Boron ...'
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
nvm install --lts=boron
nvm use --lts=boron
echo 'Setting up node server ...'
cd /tmp/
mkdir server/
cd server/
wget https://github.com/Ixam97/MaeCAN-Project/raw/master/MaeCAN-Server/MaeCAN-Server.zip
unzip MaeCAN-Server.zip
rm /var/www/html/index.html
cp -R html/ /var/www/ 
cp -R node/ /var/www/
cd /var/www/node/
npm install websocket ini
echo 'Updating device tree for CAN ...'
cd /boot/dtb
mv sun7i-a20-bananapi.dtb sun7i-a20-bananapi.dtb_org
wget lnxpps.de/bpi/bin/sun7i-a20-bananapi.dtb
echo 'Creating can2lan and can2udp ...'
cd /tmp/
git clone --depth 1 https://github.com/GBert/railroad.git
cd railroad/can2udp/src/
make
cp can2udp /usr/bin/
cp can2lan /usr/bin/
echo 'Done'

exit 0
