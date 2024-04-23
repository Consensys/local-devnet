
## Context

For rapid testing on a local machine, this gives you a docker compose file to run a local dev Eth network with proof-of-stake enabled. Please feel free to tweak as required to suit your needs
Please not is starts directly from proof-of-stake, and does not go through the Ethereum merge.

1. Execution client processes transactions and contracts and we use a custom branch of [geth](git@github.com:lightclient/go-ethereum.git). See Setup step 1
2. Consensus client runs POS logic 

**Please note that I've used `interop` mode which has the validator keys baked in.**

## Setup

1. We need a specific commit of geth, so build and containerize it

```bash
git clone --recursive git@github.com:Consensys/local-devnet.git 
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

## TODO
- Version with non interop ? Check if needed
```bash
git clone git@github.com:ethpandaops/ethereum-genesis-generator.git
cd ethereum-genesis-generator
mkdir output
docker run --rm -it -u $UID -v $PWD/output:/data -v $PWD/config-example:/config ethpandaops/ethereum-genesis-generator:latest all
```
