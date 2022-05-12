#!/bin/sh

sudo apt update
sudo apt-get update

sudo apt install -y software-properties-common apt-transport-https wget

wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install -y --fix-broken
rm chrome-remote-desktop_current_amd64.deb

sudo DEBIAN_FRONTEND=noninteractive \
    apt install -y xfce4 xfce4-goodies desktop-base

sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'

sudo apt install -y xscreensaver

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg --install google-chrome-stable_current_amd64.deb
sudo apt install -y --fix-broken
rm google-chrome-stable_current_amd64.deb

sudo systemctl disable lightdm.service

echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

sudo apt-get install apt-transport-https ca-certificates gnupg

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

sudo apt-get update
sudo apt-get install -y google-cloud-sdk

## --------------------------------------------------- ##

# setup python
sudo apt-get install python3-pip
sudo apt-get install python-dev
sudo apt autoremove

sudo apt install python3.8-venv
python3.8 -m pip install --user virtualenv

mkdir filecoin-work
cd filecoin-work

# python3.8 -m venv venv
# source venv/bin/activate
# deactivate

sudo apt install mesa-opencl-icd ocl-icd-opencl-dev gcc git bzr jq pkg-config curl clang build-essential hwloc libhwloc-dev wget -y && sudo apt upgrade -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
wget -c https://golang.org/dl/go1.17.9.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc && source ~/.bashrc

#export LOTUS_PATH=~/.lotus-local-net
#export LOTUS_MINER_PATH=~/.lotus-miner-local-net
#export LOTUS_SKIP_GENESIS_CHECK=_yes_
#export CGO_CFLAGS_ALLOW="-D__BLST_PORTABLE__"
#export CGO_CFLAGS="-D__BLST_PORTABLE__"
#
##git clone https://github.com/filecoin-project/lotus.git
#git clone https://github.com/filecoin-project/lotus lotus-local-net
#cd lotus-local-net
#rm -rf ~/.genesis-sectors
#
#make 2k
#./lotus fetch-params 2048
#./lotus-seed pre-seal --sector-size 2KiB --num-sectors 2
#./lotus-seed genesis new localnet.json
#./lotus-seed genesis add-miner localnet.json ~/.genesis-sectors/pre-seal-t01000.json


