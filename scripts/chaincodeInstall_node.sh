ccver=${1}

echo '=== chaincode version : ' $ccver

echo '====== peer1, start to chaincode install ========' 

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1/users/Admin@org1/msp
export CORE_PEER_ADDRESS=peer1:7051
export CORE_PEER_LOCALMSPID="org1"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1/peers/peer1/tls/ca.crt
peer chaincode install -l node -n emp_node -v $ccver -p /opt/gopath/src/github.com/chaincode/emp_node/

echo '====== peer1, end.  ========'

echo '====== peer2, start to chaincode install ========'

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1/users/Admin@org1/msp
export CORE_PEER_ADDRESS=peer2:7051
export CORE_PEER_LOCALMSPID="org1"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1/peers/peer2/tls/ca.crt
peer chaincode install -l node -n emp_node -v $ccver -p /opt/gopath/src/github.com/chaincode/emp_node/

echo '====== peer2, end.  ========'

echo '====== peer5, start to chaincode install ========'

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2/users/Admin@org2/msp
export CORE_PEER_ADDRESS=peer5:7051
export CORE_PEER_LOCALMSPID="org2"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2/peers/peer5/tls/ca.crt
peer chaincode install -l node -n emp_node -v $ccver -p /opt/gopath/src/github.com/chaincode/emp_node/

echo '====== peer5, end.  ========'

echo '====== peer6, start to chaincode install ========'

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2/users/Admin@org2/msp
export CORE_PEER_ADDRESS=peer6:7051
export CORE_PEER_LOCALMSPID="org2"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2/peers/peer6/tls/ca.crt
peer chaincode install -l node -n emp_node -v $ccver -p /opt/gopath/src/github.com/chaincode/emp_node/

echo '====== peer6, end.  ========'

echo '====== peer7, start to chaincode install ========'

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org3/users/Admin@org3/msp
export CORE_PEER_ADDRESS=peer7:7051
export CORE_PEER_LOCALMSPID="org3"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org3/peers/peer7/tls/ca.crt
peer chaincode install -l node -n emp_node -v $ccver -p /opt/gopath/src/github.com/chaincode/emp_node/

echo '====== peer7, end.  ========'

echo '====== peer8, start to chaincode install ========'

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org3/users/Admin@org3/msp
export CORE_PEER_ADDRESS=peer8:7051
export CORE_PEER_LOCALMSPID="org3"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org3/peers/peer8/tls/ca.crt
peer chaincode install -l node -n emp_node -v $ccver -p /opt/gopath/src/github.com/chaincode/emp_node/

echo '====== peer8, end.  ========'
