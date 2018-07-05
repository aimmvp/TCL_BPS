echo '====== peer1, start to join channel ========' 

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1/users/Admin@org1/msp
export CORE_PEER_ADDRESS=peer1:7051
export CORE_PEER_LOCALMSPID="org1"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1/peers/peer1/tls/ca.crt
peer channel join -b channel1.block

echo '====== peer1, end.  ========'

echo '====== peer2, start to join channel ========'

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1/users/Admin@org1/msp
export CORE_PEER_ADDRESS=peer2:7051
export CORE_PEER_LOCALMSPID="org1"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1/peers/peer2/tls/ca.crt
peer channel join -b channel1.block

echo '====== peer2, end.  ========'

echo '====== peer5, start to join channel ========'

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2/users/Admin@org2/msp
export CORE_PEER_ADDRESS=peer5:7051
export CORE_PEER_LOCALMSPID="org2"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2/peers/peer5/tls/ca.crt
peer channel join -b channel1.block

echo '====== peer5, end.  ========'

echo '====== peer6, start to join channel ========'

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2/users/Admin@org2/msp
export CORE_PEER_ADDRESS=peer6:7051
export CORE_PEER_LOCALMSPID="org2"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2/peers/peer6/tls/ca.crt
peer channel join -b channel1.block

echo '====== peer6, end.  ========'
