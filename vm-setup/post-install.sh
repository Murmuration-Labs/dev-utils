#!/bin/bash

sleep 300
echo '############################'
echo 'Starting post script: installing lotus, go, and setting up python libraries.'
echo '############################'

sudo mv /dev-utils ~/dev-utils

# setup python
sudo apt install -y libzmq3-dev

sudo apt install -y python3.9
sudo apt-get install -y python3-pip
sudo apt-get install -y python3.9-dev

sudo apt install -y python3.9-venv
python3.9 -m pip install --user virtualenv

cd
git clone https://github.com/keyko-io/dev-utils.git

mkdir filecoin-work
cd filecoin-work

sudo apt install -y mesa-opencl-icd ocl-icd-opencl-dev gcc git bzr jq pkg-config curl clang build-essential hwloc libhwloc-dev wget -y && sudo apt upgrade -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > install_rust.sh
chmod 755 install_rust.sh
./install_rust.sh -y
wget -c https://golang.org/dl/go1.17.9.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
export PATH=$PATH:/usr/local/go/bin

git clone https://github.com/filecoin-project/lotus.git
cd lotus
git checkout v1.13.1

#export LOTUS_PATH=~/.lotusDevnet
#export LOTUS_MINER_PATH=~/.lotusminerDevnet
#export LOTUS_SKIP_GENESIS_CHECK=_yes_
#export CGO_CFLAGS_ALLOW="-D__BLST_PORTABLE__"
#export CGO_CFLAGS="-D__BLST_PORTABLE__"
echo 'export LOTUS_PATH=~/.lotusDevnet' >> ~/.bashrc
echo 'export LOTUS_MINER_PATH=~/.lotusminerDevnet' >> ~/.bashrc
echo 'export LOTUS_SKIP_GENESIS_CHECK=_yes_' >> ~/.bashrc
echo 'export CGO_CFLAGS_ALLOW="-D__BLST_PORTABLE__"' >> ~/.bashrc
echo 'export CGO_CFLAGS="-D__BLST_PORTABLE__"' >> ~/.bashrc

source ~/.bashrc

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

# BITSCREEN setup -------------------------------#
cd ~/filecoin-work/
python3.9 -m venv venv
source venv/bin/activate

python3.9 -m pip install bitscreen-cli
python3.9 -m pip uninstall -y typer
python3.9 -m pip install typer

export LOTUS_PATH=~/.lotusDevnet
export LOTUS_MINER_PATH=~/.lotusminerDevnet
export PATH=$PATH:/usr/local/go/bin

#bitscreen-cli auth login
bitscreen-cli setup install --cli --key=$1

#deactivate
