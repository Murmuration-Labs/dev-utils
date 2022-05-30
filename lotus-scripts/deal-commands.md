Before issuing commands, export these envvars in the new terminal:
```bash
cd ~/filecoin-work/lotus

export LOTUS_PATH=~/.lotusDevnet
export LOTUS_MINER_PATH=~/.lotusminerDevnet
export LOTUS_SKIP_GENESIS_CHECK=_yes_
export CGO_CFLAGS_ALLOW="-D__BLST_PORTABLE__"
export CGO_CFLAGS="-D__BLST_PORTABLE__"

```

## Starting lotus daemon and miner
Starting lotus daemon
./lotus daemon --lotus-make-genesis=devgen.car --genesis-template=localnet.json --bootstrap=false &

Starting lotus miner in a different console
./lotus-miner run --nosync & 

## Starting a storage deal
First, import the file and copy the CID from the output
./lotus client import testfile.txt

Submit storage deal, use the CID from the import step
./lotus client deal CID t01000 0.000000005 518400

View deals here
./lotus client list-deals -v


Check the miner's pending-publish deals
./lotus-miner storage-deals pending-publish

Publish any pending-publish deals immediately
./lotus-miner storage-deals pending-publish --publish-now

## Retrieve a file
./lotus client retrieve --miner t01000 CID /tmp/retrieved-file
