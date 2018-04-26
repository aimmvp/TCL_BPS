#! /bin/bash

# Run Docker container for Fabric CA server

name=${1:-ca1}  # name of the container and CA server
port=${2:-7054} # listening port for CA server
type=${3:-peer}  # 'peer' or 'orderer'
org_name=${4:-org1} # organization name
tls_enabled=${5:-${FABRIC_CA_SERVER_TLS_ENABLED:-false}} # TLS is enabled or not: true | false
#docker_network=$6
fabric_version=$6

# References
#   - http://hyperledger-fabric-ca.readthedocs.io/en/latest/users-guide.html#fabric-ca-server
#   -

# TODO Check if the docker container named ${name} is already run or not.
# TODO Check if the port ${port} is already in use or not

#host_base_dir=`pwd`/../generated/crypto/${type}Organizations/${org_name}.com
host_base_dir=`pwd`/../generated/crypto/${type}Organizations/${org_name}
fabric_ca_server_home=`pwd`/../provision/production/${name}

sudo mkdir -p ${fabric_ca_server_home}
sudo chgrp -R blockchain ${fabric_ca_server_home}
sudo chown -R $USER ${fabric_ca_server_home}


keyfile=$(find ${host_base_dir}/ca -type f ! -name *.pem | { read fullpath; echo ${fullpath##*/}; })
certfile=$(find ${host_base_dir}/ca -type f -name *.pem | { read fullpath; echo ${fullpath##*/}; })

if [ $? -ne 0 ]; then
  echo ""
  echo "Fail to find key file for CA of '${org_name}' under '${host_base_dir}'"
  echo ""
  exit 1
else
  echo ""
  # echo "Succefully found key fie for CA : '${keyfile}'"
fi

# TODO
#  - -e FABRIC_CA_SERVER_TLS_CERTFILE=/etc/hyperledger/fabric-ca-server/ca/${certfile} \
#  - -e FABRIC_CA_SERVER_TLS_KEYFILE=/etc/hyperledger/fabric-ca-server/ca/${keyfile} \

# TODO What is the difference between specifying FABRIC_CA_SERVER_HOME and specifying FABRIC_CA_HOME
# => http://hyperledger-fabric-ca.readthedocs.io/en/latest/users-guide.html#fabric-ca-server

docker run -itd \
--name ${name} \
-p ${port}:7054 \
-e FABRIC_CA_SERVER_HOME=/etc/hyperledger/fabric-ca-server-home \
-e FABRIC_CA_SERVER_PORT=7054 \
-e FABRIC_CA_SERVER_DEBUG=${FABRIC_CA_SERVER_DEBUG:-false} \
-e FABRIC_CA_SERVER_TLS_ENABLED=${tls_enabled} \
-e FABRIC_CA_SERVER_CA_NAME=${name} \
-e FABRIC_CA_SERVER_CA_KEYFILE=/etc/hyperledger/fabric-ca-server/ca/${keyfile} \
-e FABRIC_CA_SERVER_CA_CERTFILE=/etc/hyperledger/fabric-ca-server/ca/${certfile} \
-e FABRIC_CA_SERVER_DB_TLS_ENABLED=false \
-e FABRIC_CA_SERVER_LDAP_ENABLED=false \
-v ${host_base_dir}/ca:/etc/hyperledger/fabric-ca-server/ca \
-v ${fabric_ca_server_home}:/etc/hyperledger/fabric-ca-server-home \
hyperledger/fabric-ca:${fabric_version} \
fabric-ca-server start -b admin2:admin1234


#--log-driver gelf \
#--log-opt gelf-address=udp://169.56.90.141:12204 \
#--log-opt tag=\"${name}\" \
