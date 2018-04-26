TAG=$1
echo $TAG
docker run -itd \
--name kafka1 \
--link zk1:zk1 \
--network qa-test-net \
-p 9092:9092 \
-p 9999:9999 \
-e KAFKA_BROKER_ID=0 \
-e KAFKA_UNCLEAN_LEADER_ELECTION_ENABLE=false \
-e KAFKA_DEFAULT_REPLICATION_FACTOR=1 \
-e KAFKA_ZOOKEEPER_CONNECT=zk1:2181 \
-e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=qa-test-net \
hyperledger/fabric-kafka:$TAG #x86_64-1.0.3
