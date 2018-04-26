#cryptogen generate --config=./crypto-config.yaml
go run ../common/tools/cryptogen/main.go  generate --config=./crypto-config.yaml
ln -Fs crypto-config crypto
