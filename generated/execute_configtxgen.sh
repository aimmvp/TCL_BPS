export FABRIC_CFG_PATH=$PWD
configtxgen -profile kafka2org -outputBlock ./genesis.block
echo 'create genesis.block'

export CHANNEL_NAME=channel1
configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel.tx -channelID $CHANNEL_NAME 

echo 'create channeltx'

configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./org1Anchors.tx -channelID $CHANNEL_NAME -asOrg org1

configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./org2Anchors.tx -channelID $CHANNEL_NAME -asOrg org2

configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./org3Anchors.tx -channelID $CHANNEL_NAME -asOrg org3


