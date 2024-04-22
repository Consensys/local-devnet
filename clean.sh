# docker rm -f $(docker ps -a -q)
docker compose rm -sfv
docker volume rm local-devnet_grafana local-devnet_prometheus
rm -rf ./consensus/beacondata ./consensus/validatordata ./consensus/genesis.ssz
rm -rf ./execution/geth
rm -rf ./logs/execution/*.log ./logs/consensus/*.log