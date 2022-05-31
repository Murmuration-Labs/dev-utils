#!/bin/bash

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
