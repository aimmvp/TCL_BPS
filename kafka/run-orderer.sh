  # Parameters
  # $1 : TLS Enabled
  TAG=$1
  name=$2
  port=$3
  msp_id=$4
  org_name=$5
  tls_enabled=$6

  docker_network=$7

  orderer_home=`pwd`/../provision/production/${name}

  sudo mkdir -p ${orderer_home}
  sudo chgrp -R blockchain ${orderer_home}
  sudo chown -R $USER ${orderer_home}

  docker run -itd \
  --name ${name} -p ${port}:7050 \
  --network="${docker_network}" \
  -e GRPC_TRACE=server_channel \
  -e GRPC_VERBOSITY=error \
  -e ORDERER_GENERAL_LEDGERTYPE=file \
  -e ORDERER_FILELEDGER_LOCATION=/var/hyperledger/production/ \
  -e ORDERER_GENERAL_LOGLEVEL=debug \
  -e ORDERER_GENERAL_LISTENADDRESS=0.0.0.0 \
  -e ORDERER_GENERAL_GENESISMETHOD=file \
  -e ORDERER_GENERAL_GENESISFILE=/etc/hyperledger/configtx/genesis.block \
  -e ORDERER_GENERAL_LOCALMSPID=${msp_id} \
  -e ORDERER_GENERAL_LOCALMSPDIR=/etc/hyperledger/msp \
  -e ORDERER_GENERAL_TLS_ENABLED=${tls_enabled} \
  -e ORDERER_GENERAL_TLS_PRIVATEKEY=/etc/hyperledger/tls/server.key \
  -e ORDERER_GENERAL_TLS_CERTIFICATE=/etc/hyperledger/tls/server.crt \
  -e ORDERER_GENERAL_TLS_ROOTCAS=[/etc/hyperledger/tls/ca.crt] \
  -e ORDERER_GENERAL_BATCHTIMEOUT=2s \
  -e ORDERER_GENERAL_BATCHSIZE_MAXMESSAGECOUNT=1000 \
  -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=${docker_network} \
  -v `pwd`/../provision/production/${name}:/var/hyperledger/production/ \
  -v `pwd`/../generated:/etc/hyperledger/configtx \
  -v `pwd`/../generated/crypto/ordererOrganizations/${org_name}/orderers/${name}/msp:/etc/hyperledger/msp/ \
  -v `pwd`/../generated/crypto/ordererOrganizations/${org_name}/orderers/${name}/tls:/etc/hyperledger/tls/ \
  --workdir /opt/gopath/src/github.com/hyperledger/fabric/orderer \
  hyperledger/fabric-orderer:$TAG \
  orderer
