export VERSION=1.1.0
rt VERSION=1.1.0
export PREVIEW_VERSION=0.4.6
export PREVIEW2_VERSION=0.4.6
export ARCH=$(echo "$(uname -s|tr '[:upper:]' '[:lower:]' | sed  's/mingw64_nt.*/windows/')-$(uname -m | sed 's/x84_64/amd64/g')" | awk '{print tolower($0)}')
MARCH=`uname -m`

: ${CA_TAG:="$MARCH-$VERSION"}
: ${FABRIC_TAG:="$MARCH-$VERSION"}
: ${KZ_TAG:="$MARCH-$PREVIEW2_VERSION"}
: ${COUCHDB_TAG:="$MARCH-$PREVIEW_VERSION"}

run_kafka_zookeeper() {

    cal KZ_TAG=$1
        cd kafka

    ##echo "=================>launch kafka, zookeeper"
    ./run-zookeeper.sh $KZ_TAG
    ./run-kafka.sh $KZ_TAG
}

run_orderer() {
    local FABRIC_TAG=$1

    #echo "===============================>launch orderers"

    ./run-orderer.sh $FABRIC_TAG orderer1 7050 org0 org0 true qa-test-net
    ./run-orderer.sh $FABRIC_TAG orderer2 8050 org0 org0 true qa-test-net
}

run_couchdb() {
    local COUCHDB_TAG=$1
    cd ../peers

    #echo "===========================================>launch couchdbs"

    ./run-couchdb.sh $COUCHDB_TAG couch1 5914 qa-test-net x86_64-1.0.3
    ./run-couchdb.sh $COUCHDB_TAG couch2 5924 qa-test-net x86_64-1.0.3
    ./run-couchdb.sh $COUCHDB_TAG couch5 5954 qa-test-net x86_64-1.0.3
    ./run-couchdb.sh $COUCHDB_TAG couch6 5964 qa-test-net x86_64-1.0.3
}

run_peer() {
    local FABRIC_TAG=$1

    #echo "=======================================================>launch peers"

    ./run-peer.sh $FABRIC_TAG peer1 7051 org1 org1 couch1 true peer1 true qa-test-net
    ./run-peer.sh $FABRIC_TAG peer2 7061 org1 org1 couch2 false peer1 true qa-test-net
    ./run-peer.sh $FABRIC_TAG peer5 8051 org2 org2 couch5 true peer5 true qa-test-net
    ./run-peer.sh $FABRIC_TAG peer6 8061 org2 org2 couch6 false peer5 true qa-test-net
}

run_peer_with_couch() {
    local FABRIC_TAG=$1
    local COUCHDB_TAG=$2
    echo $FABRIC_TAG $COUCHDB_TAG

    cd ../peers

    ./run-couchdb.sh $COUCHDB_TAG couch1 5914 qa-test-net x86_64-1.0.3
    ./run-peer.sh $FABRIC_TAG peer1 7051 org1 org1 couch1 true peer1 true qa-test-net

    ./run-couchdb.sh $COUCHDB_TAG couch2 5924 qa-test-net x86_64-1.0.3
    ./run-peer.sh $FABRIC_TAG peer2 7061 org1 org1 couch2 false peer1 true qa-test-net

    ./run-couchdb.sh $COUCHDB_TAG couch5 5954 qa-test-net x86_64-1.0.3
    ./run-peer.sh $FABRIC_TAG peer5 8051 org2 org2 couch5 true peer5 true qa-test-net

    ./run-couchdb.sh $COUCHDB_TAG couch6 5964 qa-test-net x86_64-1.0.3
    ./run-peer.sh $FABRIC_TAG peer6 8061 org2 org2 couch6 false peer5 true qa-test-net
}


run_ca() {
    local CA_TAG=$1
    cd ../cas

    #echo "=================================================================>launch orderer"
    ./run-ca.sh ca1 7054 peer org1 false $CA_TAG
    ./run-ca.sh ca2 8054 peer org2 false $CA_TAG
    cd ..
}


run_kafka_zookeeper ${KZ_TAG}
run_orderer ${FABRIC_TAG}
#run_peer_with_couch ${FABRIC_TAG} ${COUCHDB_TAG}
run_couchdb ${COUCHDB_TAG}
run_peer ${FABRIC_TAG} 
run_ca ${FABRIC_TAG}
