sudo docker stop $(docker ps -aq)
sudo docker rm $(docker ps -aq)
sudo docker volume rm $(docker volume ls -q)
sudo rm -rf ./provision
sudo rm -rf ./generated/crypto
sudo rm -rf ./generated/crypto-config/*
sudo rm -rf ./generated/*.tx
sudo rm -rf ./generated/*.block

