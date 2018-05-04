sudo docker stop $(docker ps -aq)
sudo docker rm $(docker ps -aq)
sudo docker volume rm $(docker volume ls -q)
sudo rm -rf ./provision/production/*
