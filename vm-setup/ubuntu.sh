#!/bin/bash

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

sudo apt-get install -y apt-transport-https ca-certificates gnupg

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

sudo apt-get update
sudo apt-get install -y google-cloud-sdk

#-----------------------------------------------------------#
# setup python

cd ~/
git clone https://github.com/keyko-io/dev-utils.git

mkdir ~/filecoin-work
cd ~/filecoin-work

sudo apt install -y mesa-opencl-icd ocl-icd-opencl-dev gcc git bzr jq pkg-config curl clang build-essential hwloc libhwloc-dev wget -y && sudo apt upgrade -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > ~/install_rust.sh
chmod 755 ~/filecoin-work/install_rust.sh
~/filecoin-work/install_rust.sh -y
wget -c https://golang.org/dl/go1.17.9.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
export PATH=$PATH:/usr/local/go/bin
export GOPATH=~/go
#source ~/.bashrc

git clone https://github.com/filecoin-project/lotus.git ~/filecoin-work/lotus
cd ~/filecoin-work/lotus
git checkout v1.13.1

export LOTUS_PATH=~/.lotusDevnet
export LOTUS_MINER_PATH=~/.lotusminerDevnet
export LOTUS_SKIP_GENESIS_CHECK=_yes_
export CGO_CFLAGS_ALLOW="-D__BLST_PORTABLE__"
export CGO_CFLAGS="-D__BLST_PORTABLE__"

make 2k
./lotus fetch-params 2048
./lotus-seed pre-seal --sector-size 2KiB --num-sectors 2
./lotus-seed genesis new localnet.json
./lotus-seed genesis add-miner localnet.json ~/.genesis-sectors/pre-seal-t01000.json

tmux new-session -s lotus -n script -d
tmux new-window -t lotus:1 -n daemon -d ./lotus daemon --lotus-make-genesis=devgen.car --genesis-template=localnet.json --bootstrap=false

sleep 10

./lotus wait-api

./lotus wallet import --as-default ~/.genesis-sectors/pre-seal-t01000.key
./lotus-miner init --genesis-miner --actor=t01000 --sector-size=2KiB --pre-sealed-sectors=~/.genesis-sectors --pre-sealed-metadata=~/.genesis-sectors/pre-seal-t01000.json --nosync

tmux new-window -t lotus:2 -n miner -d ./lotus-miner run --nosync


sudo apt install -y libzmq3-dev

sudo apt-get install -y python3-pip
sudo apt-get install -y python3.9-dev

sudo apt install -y python3.9-venv
python3.9 -m pip install --user virtualenv
