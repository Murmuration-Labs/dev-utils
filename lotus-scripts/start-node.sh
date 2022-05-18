#!/bin/bash

cd ~/filecoin-work/lotus

export LOTUS_PATH=~/.lotusDevnet
export LOTUS_MINER_PATH=~/.lotusminerDevnet
export LOTUS_SKIP_GENESIS_CHECK=_yes_
export CGO_CFLAGS_ALLOW="-D__BLST_PORTABLE__"
export CGO_CFLAGS="-D__BLST_PORTABLE__"

tmux new-session -s lotus -n script -d
tmux new-window -t lotus:1 -n daemon -d ./lotus daemon --lotus-make-genesis=devgen.car --genesis-template=localnet.json --bootstrap=false

sleep 10

./lotus wait-api

tmux new-window -t lotus:2 -n miner -d ./lotus-miner run --nosync
