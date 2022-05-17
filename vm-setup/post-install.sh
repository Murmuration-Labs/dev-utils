#!/bin/sh

# setup python
sudo apt -y install libzmq3-dev

sudo apt-get install -y python3-pip
sudo apt-get install -y python3.9-dev
sudo apt -y autoremove

sudo apt install -y python3.9-venv
python3.9 -m pip install --user virtualenv

cd
mkdir filecoin-work
cd filecoin-work

sudo apt install -y mesa-opencl-icd ocl-icd-opencl-dev gcc git bzr jq pkg-config curl clang build-essential hwloc libhwloc-dev wget -y && sudo apt upgrade -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
wget -c https://golang.org/dl/go1.17.9.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc

git clone https://github.com/filecoin-project/lotus.git
cd lotus
git checkout v1.13.1
