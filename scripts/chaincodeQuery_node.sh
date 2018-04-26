export CHANNEL_NAME=channel1
peer chaincode query -C $CHANNEL_NAME -n emp_node  -c '{"Args":["getEmployee", "dj"]}' 
