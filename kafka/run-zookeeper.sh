TAG=$1
echo $TAG
docker run -itd \
--name zk1 \
--network qa-test-net \
-p 2181:2181 \
-e CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=qa-test-net \
hyperledger/fabric-zookeeper:$TAG
