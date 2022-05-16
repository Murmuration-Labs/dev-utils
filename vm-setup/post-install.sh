#!/bin/sh

# setup python
sudo apt install libzmq3-dev

sudo apt-get install python3-pip
sudo apt-get install python-dev
sudo apt autoremove

sudo apt install python3.9-venv
python3.9 -m pip install --user virtualenv

mkdir filecoin-work
cd filecoin-work

# python3.8 -m venv venv
# source venv/bin/activate
# deactivate
# python3.8 -m pip install bitscreen-cli


sudo apt install mesa-opencl-icd ocl-icd-opencl-dev gcc git bzr jq pkg-config curl clang build-essential hwloc libhwloc-dev wget -y && sudo apt upgrade -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
wget -c https://golang.org/dl/go1.17.9.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
#source ~/.bashrc
#
#
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
#
## start node
#./lotus daemon --lotus-make-genesis=devgen.car --genesis-template=localnet.json --bootstrap=false
#
## miner
#./lotus wallet import --as-default ~/.genesis-sectors/pre-seal-t01000.key
#./lotus-miner init --genesis-miner --actor=t01000 --sector-size=2KiB --pre-sealed-sectors=~/.genesis-sectors --pre-sealed-metadata=~/.genesis-sectors/pre-seal-t01000.json --nosync
#./lotus-miner run --nosync

# setup bitscreen
# install bitscreen-cli
# run bitscreen-cli setup install
# restart lotus miner
# run storage deal
# run retrieval deal
# add cid to filter
# run retrieval deal



