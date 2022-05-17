#!/bin/sh

cd ~/filecoin-work/lotus

export LOTUS_PATH=~/.lotusDevnet
export LOTUS_MINER_PATH=~/.lotusminerDevnet
export LOTUS_SKIP_GENESIS_CHECK=_yes_
export CGO_CFLAGS_ALLOW="-D__BLST_PORTABLE__"
export CGO_CFLAGS="-D__BLST_PORTABLE__"

# miner
./lotus wallet import --as-default ~/.genesis-sectors/pre-seal-t01000.key
./lotus-miner init --genesis-miner --actor=t01000 --sector-size=2KiB --pre-sealed-sectors=~/.genesis-sectors --pre-sealed-metadata=~/.genesis-sectors/pre-seal-t01000.json --nosync
./lotus-miner run --nosync
#tmux new-window -t lotus:2 -n miner -d ./lotus-miner run --nosync
