#!/bin/sh

# setup python
sudo apt install libzmq3-dev

sudo apt-get install python3-pip
sudo apt-get install python3.9-dev
sudo apt autoremove

sudo apt install python3.9-venv
python3.9 -m pip install --user virtualenv

mkdir filecoin-work
cd filecoin-work

sudo apt install mesa-opencl-icd ocl-icd-opencl-dev gcc git bzr jq pkg-config curl clang build-essential hwloc libhwloc-dev wget -y && sudo apt upgrade -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
wget -c https://golang.org/dl/go1.17.9.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc


git clone https://github.com/filecoin-project/lotus.git
git checkout v1.15.3-rc1
