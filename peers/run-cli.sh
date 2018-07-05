# cli
# Parameters
# $1 : TLS Enabled

name=$1
default_peer=$2
msp_id=$3
org_name=$4
tls_enabled=$5
docker_network=$6

docker run -itd \
--name ${name} \
--network="${docker_network}" \
-e GOPATH=/opt/gopath \
-e CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock \
-e CORE_LOGGING_LEVEL=DEBUG \
-e CORE_PEER_ID=${name} \
-e CORE_PEER_CHAINCODELISTENADDRESS=${name}:7052 \
-e CORE_PEER_GOSSIP_EXTERNALENDPOINT=${name}:7051 \
-e CORE_PEER_ADDRESS=${default_peer}:7051 \
-e CORE_PEER_LOCALMSPID=${msp_id} \
-e CORE_PEER_TLS_ENABLED=${tls_enabled} \
-e CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/${org_name}/peers/${default_peer}/tls/server.crt \
-e CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/${org_name}/peers/${default_peer}/tls/server.key \
-e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/${org_name}/peers/${default_peer}/tls/ca.crt \
-e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/${org_name}/users/Admin@${org_name}/msp \
-v /var/run/:/host/var/run/ \
-v ~/provision/chaincode/go/:/opt/gopath/src/github.com/hyperledger/fabric/examples/chaincode/go \
-v ~/provision/generated/crypto:/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ \
-v ~/provision/generated:/opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts \
-v ~/provision/peers:/opt/gopath/src/github.com/hyperledger/fabric/peer/scripts \
--workdir /opt/gopath/src/github.com/hyperledger/fabric/peer \
hyperledger/fabric-tools:latest \
peer node start --peer-defaultchain=false
