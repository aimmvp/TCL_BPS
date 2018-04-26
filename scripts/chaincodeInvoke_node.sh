export CHANNEL_NAME=channel1
peer chaincode invoke -o orderer1:7050 --tls $CORE_PEER_TLS_ENABLED --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/org0/orderers/orderer1/msp/tlscacerts/tlsca.org0-cert.pem -C $CHANNEL_NAME -n emp_node  -c '{"Args":["create", "dj", "dongjo", "40"]}' 
