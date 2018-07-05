export CHANNEL_NAME=channel1
peer channel create -o orderer1:7050 -c $CHANNEL_NAME -f ../channel-artifacts/channel.tx --tls $CORE_PEER_TLS_ENABLED --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/org0/orderers/orderer1/msp/tlscacerts/tlsca.org0-cert.pem
