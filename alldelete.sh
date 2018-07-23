sudo docker stop $(docker ps -aq)
sudo docker rm $(docker ps -aq)
sudo docker volume rm $(docker volume ls -q)
sudo rm -rf ./provision/production/*
sudo rm -rf ./generated/*.tx
sudo rm -rf ./generated/*.block

