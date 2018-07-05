ccver=${1}

echo '=== chaincode version : ' $ccver

export CHANNEL_NAME=channel1
peer chaincode instantiate -o orderer1:7050 --tls $CORE_PEER_TLS_ENABLED --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/org0/orderers/orderer1/msp/tlscacerts/tlsca.org0-cert.pem -C $CHANNEL_NAME -n emp_node -v $ccver -c '{"Args":[]}' -P "OR ('org1.member','org2.member')"
