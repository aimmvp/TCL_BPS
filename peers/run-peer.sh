    # Peer
    
    # Parameters
    # $1 : peer-container-name
    # $2 : peer-port(7051)
    # $3 : peer-port(7053)
    # $4 : peer msp id
    # $5 : peer org name
    # $6 : couchdb-container-name
    # $7 : is_orgleader; true or false
    # $8 : bootstrap address
    # $9 : TLS Enabled
    # $10 : docker network

    TAG=${1}
    name=${2}
    port=${3}
    chaincode_listen_port=`expr ${port} + 1`
    event_port=`expr ${port} + 2`
    msp_id=${4}
    org_name=${5}
    couchdb=${6}
    is_orgleader=${7}
    gossip_bootstrap=${8}
    tls_enabled=${9}
    docker_network=${10}
    fabric_version=x86_64-1.0.3

    peer_home=`pwd`/../provision/production/${name}

    echo "run-peer.sh  TAG : " $TAG
    sudo mkdir -p ${peer_home}
    sudo chgrp -R blockchain ${peer_home}
    sudo chown -R $USER ${peer_home}


    echo Launching peer... ${TAG} ${name} ${port} ${event_port} ${msp_id} ${org_name} ${couchdb} ${is_orgleader} ${gossip_bootstrap} ${docker_network} ${tls_enabled}

    docker run -itd \
    --name ${name} \
    --network="${docker_network}" \
    -p ${port}:7051 \
    -p ${chaincode_listen_port}:7052 \
    -p ${event_port}:7053 \
    -e CORE_LOGGING_LEVEL=debug \
    -e CORE_NEXT=true \
    -e CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock \
    -e CORE_PEER_ID=${name} \
    -e CORE_PEER_NETWORKID=${name} \
    -e CORE_PEER_ADDRESS=${name}:7051 \
    -e CORE_PEER_CHAINCODELISTENADDRESS=${name}:7052 \
    -e CORE_PEER_ENDORSER_ENABLED=true \
    -e CORE_PEER_LOCALMSPID=${msp_id} \
    -e CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/ \
    -e CORE_PEER_GOSSIP_USELEADERELECTION=false \
    -e CORE_PEER_GOSSIP_ORGLEADER=${is_orgleader} \
    -e CORE_PEER_GOSSIP_EXTERNALENDPOINT=${name}:7051 \
    -e CORE_PEER_GOSSIP_BOOTSTRAP=${gossip_bootstrap}:7051 \
    -e CORE_PEER_GOSSIP_SKIPHANDSHAKE=true \
    -e CORE_PEER_EVENTS_BUFFERSIZE=2000 \
    -e CORE_PEER_EVENTS_TIMEOUT=20ms \
    -e CORE_PEER_TLS_ENABLED=${tls_enabled} \
    -e CORE_PEER_TLS_CERT_FILE=/etc/hyperledger/tls/server.crt \
    -e CORE_PEER_TLS_KEY_FILE=/etc/hyperledger/tls/server.key \
    -e CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/tls/ca.crt \
    -e CORE_PEER_PROFILE_ENABLED=false \
    -e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=${docker_network} \
    -e CORE_LEDGER_STATE_STATEDATABASE=CouchDB \
    -e CORE_LEDGER_STATE_COUCHDBCONFIG_COUCHDBADDRESS=${couchdb}:5984 \
    -e CORE_LEDGER_STATE_COUCHDBCONFIG_USERNAME=admin \
    -e CORE_LEDGER_STATE_COUCHDBCONFIG_PASSWORD=admin!@34 \
    -e CORE_LEDGER_STATE_HISTORYDATABASE=true \
    -v /var/run/:/host/var/run/ \
    -v `pwd`/../provision/production/${name}:/var/hyperledger/production/ \
    -v `pwd`/../generated/crypto/peerOrganizations/${org_name}/peers/${name}/msp:/etc/hyperledger/msp \
    -v `pwd`/../generated/crypto/peerOrganizations/${org_name}/peers/${name}/tls:/etc/hyperledger/tls \
    --workdir /opt/gopath/src/github.com/hyperledger/fabric \
    hyperledger/fabric-peer:$TAG \
    peer node start 

