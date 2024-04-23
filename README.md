
## Context

For rapid testing on a local machine, this gives you a docker compose file to run a local dev Eth network with proof-of-stake enabled. Please feel free to tweak as required to suit your needs
Please not is starts directly from proof-of-stake, and does not go through the Ethereum merge.

1. Execution client processes transactions and contracts and we use a custom branch of [geth](git@github.com:lightclient/go-ethereum.git). See Setup step 1
2. Consensus client runs POS logic 

**Please note that I've used `interop` mode which has the validator keys baked in.**

## Setup

1. We need a specific commit of geth, so build and containerize it

```bash
git submodule update --init --recursive
```

## Accounts

The default account `0xfa84625a86108cf199e9d975e5b2b57098d65033` comes seeded for txns, contracts etc. It is also set as the fee recipient for transaction fees proposed validators

There are also 3 dev/test accounts that are seeded well. Details in the [genesis file](./execution/genesis.json)

## Run

Spin everything down and clean things up

```bash
docker compose down && sudo ./clean.sh 
```

Start things up

```bash
docker compose up -d
```

Test blockhead increasing 

```bash
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":51}' -H 'Content-Type: application/json' http://127.0.0.1:8545
```

Test with a smart contract 

```bash
cd smart_contracts
npm i
npm run tx
```
which will compile the simple storage contract, deploy it and then interact with the contract ie read/write a value. Logs resemble the following:

```bash

> @consensys-software/smart_contracts@1.0.0 tx
> node scripts/send_tx.js

Contract deployed at address: 0x76dEd0b970ACEadb304e3B3d5420728C6272DE1a
Use the smart contracts 'get' function to read the contract's constructor initialized value .. 
Obtained value at deployed contract is: 47
Use the smart contracts 'set' function to update that value to 123 .. 
Verify the updated value that was set .. 
Obtained value at deployed contract is: 123
```

and logs in geth

```bash
INFO [04-23|12:03:27.388] Chain head was updated                   number=180 hash=a6255e..390da1 root=904cf6..2894d8 elapsed=2.650466ms
INFO [04-23|12:03:27.397] Starting work on payload                 id=0xe1da1520283e8e01
INFO [04-23|12:03:27.397] Updated payload                          id=0xe1da1520283e8e01 number=181 hash=3ef191..e2a6f6 txs=0 withdrawals=0 gas=0       fees=0           root=904cf6..2894d8 elapsed="82.086µs"
INFO [04-23|12:03:33.219] Submitted contract creation              hash=0x193db485fd87ee4c2ba8119a9383b926305100161d6e92bc1290e34764a2d47d from=0xFa84625A86108cF199E9d975E5b2B57098D65033 nonce=4 contract=0x44FC7a2Affd6C80456A52eb698A6ACfD0614da4B value=0
INFO [04-23|12:03:33.401] Updated payload                          id=0xe1da1520283e8e01 number=181 hash=3a64e6..f4d94e txs=1 withdrawals=0 gas=200,213 fees=0.000200213 root=c1ac7f..80729c elapsed="779.462µs"
INFO [04-23|12:03:39.338] Stopping work on payload                 id=0xe1da1520283e8e01 reason=delivery
INFO [04-23|12:03:39.370] Imported new potential chain segment     number=181 hash=3a64e6..f4d94e blocks=1 txs=1 mgas=0.200 elapsed=8.223ms     mgasps=24.347 snapdiffs=910.00B triedirty=5.87KiB
INFO [04-23|12:03:39.388] Chain head was updated                   number=181 hash=3a64e6..f4d94e root=c1ac7f..80729c elapsed=2.978389ms
INFO [04-23|12:03:39.399] Starting work on payload                 id=0x1f0914adb9124195
INFO [04-23|12:03:39.400] Updated payload                          id=0x1f0914adb9124195 number=182 hash=a655ef..893c33 txs=0 withdrawals=0 gas=0       fees=0           root=c1ac7f..80729c elapsed="79.73µs"
INFO [04-23|12:03:41.419] Submitted transaction                    hash=0xa60057a2cbad99d812d57d4bd3bd64cbbfcc7347e53e27adbf5d090c7068de38 from=0xFa84625A86108cF199E9d975E5b2B57098D65033 nonce=5 recipient=0x44FC7a2Affd6C80456A52eb698A6ACfD0614da4B value=0
INFO [04-23|12:03:43.403] Updated payload                          id=0x1f0914adb9124195 number=182 hash=c3246e..4623de txs=1 withdrawals=0 gas=28222   fees=2.8222e-05  root=2e29c5..03becb elapsed=1.106ms
INFO [04-23|12:03:51.386] Stopping work on payload                 id=0x1f0914adb9124195 reason=delivery
INFO [04-23|12:03:51.410] Imported new potential chain segment     number=182 hash=c3246e..4623de blocks=1 txs=1 mgas=0.028 elapsed=3.894ms     mgasps=7.246  snapdiffs=1.07KiB triedirty=7.18KiB
INFO [04-23|12:03:51.429] Chain head was updated                   number=182 hash=c3246e..4623de root=2e29c5..03becb elapsed=2.355356ms
INFO [04-23|12:03:51.445] Starting work on payload                 id=0x2973586e4dd68e55
INFO [04-23|12:03:51.446] Updated payload                          id=0x2973586e4dd68e55 number=183 hash=323b0e..9fb331 txs=0 withdrawals=0 gas=0       fees=0           root=2e29c5..03becb elapsed="68.564µs"
INFO [04-23|12:04:03.346] Stopping work on payload                 id=0x2973586e4dd68e55 reason=delivery
INFO [04-23|12:04:03.370] Imported new potential chain segment     number=183 hash=323b0e..9fb331 blocks=1 txs=0 mgas=0.000 elapsed=10.660ms    mgasps=0.000  snapdiffs=1.07KiB triedirty=7.18KiB
INFO [04-23|12:04:03.387] Chain head was updated                   number=183 hash=323b0e..9fb331 root=2e29c5..03becb elapsed=2.479564ms
INFO [04-23|12:04:03.397] Starting work on payload                 id=0x969d1dd1e8fbabde
INFO [04-23|12:04:03.397] Updated payload                          id=0x969d1dd1e8fbabde number=184 hash=8a721c..1d1eb4 txs=0 withdrawals=0 gas=0       fees=0           root=2e29c5..03becb elapsed="66.688µs"
```


## TODO

- Version with non interop ? Check if needed

```bash
git clone git@github.com:ethpandaops/ethereum-genesis-generator.git
cd ethereum-genesis-generator
mkdir output
docker run --rm -it -u $UID -v $PWD/output:/data -v $PWD/config-example:/config ethpandaops/ethereum-genesis-generator:latest all
```
