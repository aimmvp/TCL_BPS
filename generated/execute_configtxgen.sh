 export FABRIC_CFG_PATH=$PWD
 go run ../common/tools/configtxgen/main.go -profile kafka2org -outputBlock ./genesis.block
 echo 'create genesis.block'

 export CHANNEL_NAME=channel1
 go run ../common/tools/configtxgen/main.go -profile TwoOrgsChannel -outputCreateChannelTx ./channel.tx -channelID $CHANNEL_NAME 

 echo 'create channeltx'

 go run ../common/tools/configtxgen/main.go -profile TwoOrgsChannel -outputAnchorPeersUpdate ./org1Anchors.tx -channelID $CHANNEL_NAME -asOrg org1

 go run ../common/tools/configtxgen/main.go -profile TwoOrgsChannel -outputAnchorPeersUpdate ./org2Anchors.tx -channelID $CHANNEL_NAME -asOrg org2


 
