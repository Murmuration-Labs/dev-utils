#!/bin/bash

# setup python venv
# install bitscreen-cli
# run bitscreen-cli setup install
# restart lotus miner
# run storage deal
# run retrieval deal
# add cid to filter
# run retrieval deal

cd ~/filecoin-work/
python3.9 -m venv venv
source venv/bin/activate

python3.9 -m pip install bitscreen-cli
python3.9 -m pip uninstall -y typer
python3.9 -m pip install typer

export LOTUS_PATH=~/.lotusDevnet
export LOTUS_MINER_PATH=~/.lotusminerDevnet

#bitscreen-cli auth login
bitscreen-cli setup install --cli=1 --key=$1

#deactivate

