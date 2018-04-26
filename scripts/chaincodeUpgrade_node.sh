ccver=${1}

echo '=== chaincode version : ' $ccver

export CHANNEL_NAME=channel1

echo '====== peer1, start to chaincode install ========' 

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1/users/Admin@org1/msp
export CORE_PEER_ADDRESS=peer1:7051
export CORE_PEER_LOCALMSPID="org1"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1/peers/peer1/tls/ca.crt
peer chaincode upgrade -o orderer1:7050 --tls $CORE_PEER_TLS_ENABLED --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/org0/orderers/orderer1/msp/tlscacerts/tlsca.org0-cert.pem -C $CHANNEL_NAME -n emp_node -v $ccver -c '{"Args":[]}' -P "OR ('org1.member','org2.member','org3.member')"

echo '====== peer1, end.  ========'

#echo '====== peer5, start to chaincode install ========' 

#export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2/users/Admin@org2/msp
#export CORE_PEER_ADDRESS=peer5:7051
#export CORE_PEER_LOCALMSPID="org2"
#export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2/peers/peer5/tls/ca.crt
#peer chaincode upgrade -o orderer1:7050 --tls $CORE_PEER_TLS_ENABLED --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/org0/orderers/orderer1/msp/tlscacerts/tlsca.org0-cert.pem -C $CHANNEL_NAME -n emp_node -v $ccver -c '{"Args":[]}' -P "OR ('org1.member','org2.member','org3.member')"

#echo '====== peer5, end.  ========'

#echo '====== peer7, start to chaincode install ========' 

#export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org3/users/Admin@org3/msp
#export CORE_PEER_ADDRESS=peer7:7051
#export CORE_PEER_LOCALMSPID="org3"
#export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org3/peers/peer7/tls/ca.crt
#peer chaincode upgrade -o orderer1:7050 --tls $CORE_PEER_TLS_ENABLED --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/org0/orderers/orderer1/msp/tlscacerts/tlsca.org0-cert.pem -C $CHANNEL_NAME -n emp_node -v $ccver -c '{"Args":[]}' -P "OR ('org1.member','org2.member','org3.member')"

#echo '====== peer7, end.  ========'


