# Bước 1 -- Cài Chainlaunch
curl -fsSL https://chainlaunch.dev/deploy.sh | bash

# Bước 2 -- Khởi tạo cụm Orderer (Raft 3-node, chịu lỗi đơn điểm)
chainlaunch node create --name "orderer0-org1msp" --type "FABRIC_ORDERER" --mspid "org1msp" --port 9000
chainlaunch node create --name "orderer1-org1msp" --type "FABRIC_ORDERER" --mspid "org1msp" --port 9100
chainlaunch node create --name "orderer2-org1msp" --type "FABRIC_ORDERER" --mspid "org1msp" --port 9200

# Bước 3 -- Khởi tạo Peer node
chainlaunch node create --name "peer0-org1msp" --type "FABRIC_PEER" --mspid "org1msp" --port 7000
chainlaunch node create --name "peer1-org1msp" --type "FABRIC_PEER" --mspid "org1msp" --port 7100

# Bước 4 -- Tạo kênh votechannel và liên kết Peer
chainlaunch network create --name "votechannel" --platform "fabric" --orderers "orderer0-org1msp,orderer1-org1msp,orderer2-org1msp"
chainlaunch network join-node --network-id "net-xyz123" --node "peer0-org1msp"
chainlaunch network join-node --network-id "net-xyz123" --node "peer1-org1msp"

# Bước 5 -- Triển khai chaincode votecc (Define → Deploy → InitLedger)
chainlaunch chaincode define --network-id "net-xyz123" --name "votecc" --version "1.0" --sequence 1 --image "docker.io/tuienn/votecc:latest" --init-required true
chainlaunch chaincode deploy --network-id "net-xyz123" --name "votecc" --peers "peer0-org1msp,peer1-org1msp"
chainlaunch chaincode invoke --network-id "net-xyz123" --name "votecc" --fcn "InitLedger" --args "[]"

# Bước 6 -- Cấp phát định danh cho ứng dụng client (Register → Enroll)
fabric-ca-client register --url https://localhost:7054 --id.name "e-voting-client" --id.secret "ClientSecret123" --id.type "client" --id.affiliation "org1" --tls.certfiles $FABRIC_CA_CLIENT_HOME/tls-root-cert.pem
fabric-ca-client enroll --url https://e-voting-client:ClientSecret123@localhost:7054 --mspdir $FABRIC_CA_CLIENT_HOME/e-voting-client/msp --tls.certfiles $FABRIC_CA_CLIENT_HOME/tls-root-cert.pem
