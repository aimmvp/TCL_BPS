TAG=${1}
name=${2:-couch0}
port=${3:-5984}
docker_network=${4:-hyp-net}

sudo rm -rf `pwd`/../provision/production/couchdb/$name

docker run -itd \
--name $name \
--network="$docker_network" \
-p $port:5984 \
-e COUCHDB_USER=admin \
-e COUCHDB_PASSWORD=admin!@34 \
-v `pwd`/../provision/production/couchdb/$name/data:/opt/couchdb/data \
-v `pwd`/../provision/production/couchdb/$name/var/log:/opt/couchdb/var/log \
hyperledger/fabric-couchdb:$TAG

echo "Waiting 2 seconds for CouchDB to be launched completely."
sleep 2

echo ""
echo "CouchDB container named '$name' in single node has launched successfully."
echo "Access 'http://localhost:$port/_utils' to manage $name."
echo "Data files : '`pwd`/../provision/production/couchdb/$name/data/' in host filesystem."
echo "Log file  : '`pwd`/../provision/production/couchdb/$name/var/log/couch.log' in host filesystem."
echo ""

