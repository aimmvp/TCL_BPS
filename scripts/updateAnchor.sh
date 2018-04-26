export CHANNEL_NAME=channel1

echo '====== peer1, start to update channel anchor ========' 

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1/users/Admin@org1/msp
export CORE_PEER_ADDRESS=peer1:7051
export CORE_PEER_LOCALMSPID="org1"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1/peers/peer1/tls/ca.crt
peer channel update -o orderer1:7050 -c $CHANNEL_NAME -f ../channel-artifacts/org1Anchors.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/org0/orderers/orderer1/msp/tlscacerts/tlsca.org0-cert.pem

echo '====== peer1, end.  ========'

echo '====== peer5, start to update channel anchor ========' 

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2/users/Admin@org2/msp
export CORE_PEER_ADDRESS=peer5:7051
export CORE_PEER_LOCALMSPID="org2"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2/peers/peer5/tls/ca.crt
peer channel update -o orderer2:7050 -c $CHANNEL_NAME -f ../channel-artifacts/org2Anchors.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/org0/orderers/orderer2/msp/tlscacerts/tlsca.org0-cert.pem

echo '====== peer5, end.  ========'

echo '====== peer8, start to update channel anchor ========' 

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org3/users/Admin@org3/msp
export CORE_PEER_ADDRESS=peer8:7051
export CORE_PEER_LOCALMSPID="org3"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org3/peers/peer8/tls/ca.crt
peer channel update -o orderer2:7050 -c $CHANNEL_NAME -f ../channel-artifacts/org3Anchors.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/org0/orderers/orderer2/msp/tlscacerts/tlsca.org0-cert.pem

echo '====== peer8, end.  ========'
