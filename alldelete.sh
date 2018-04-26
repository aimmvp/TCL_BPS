sudo docker stop $(docker ps -aq)
sudo docker rm $(docker ps -aq)
sudo docker volume rm $(docker volume ls -q)
sudo docker network prune
sudo rm -rf ./provision/production/*
