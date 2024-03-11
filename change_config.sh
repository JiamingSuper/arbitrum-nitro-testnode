#!/bin/bash

# 检查参数数量是否正确
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <ip_address> <number> <option>"
    exit 1
fi

# 提取参数
ip_address=$1
number=$2
option=$3

cp ./scripts/index.txt ./scripts/index.ts
cp sequencer_config.txt sequencer_config.json
cp deployed_chain_info.txt deployed_chain_info.json
cp deployment.txt deployment.json
cp l2_chain_info.txt l2_chain_info.json
cp docker-compose.txt docker-compose.yaml

sed -i "s/\"url\": \"ws:\/\/geth:8546\"/\"url\": \"ws:\/\/$ip_address:8546\"/" sequencer_config.json
sed -i "s/ws:\/\/geth:8546/ws:\/\/$ip_address:8546/" ./scripts/index.ts
sed -i "s/http:\/\/sequencer:8547/http:\/\/$ip_address:8547/" sequencer_config.json
sed -i "s/ws:\/\/sequencer:9642/ws:\/\/$ip_address:9642/" docker-compose.yaml

# # 根据第三个参数进行不同的替换操作
# case $option in
#     1)
#         sed -i "s/\"0x6A568afe0f82d34759347bb36F14A6bB171d2CBe\"/\"0x46225F4cee2b4A1d506C7f894bb3dAeB21BF1596\"/" sequencer_config.json
#         sed -i "s/\"0xe2148eE53c0755215Df69b2616E552154EdC584f\"/\"0x19ED240ddd4DDEeDdF2B77aA279F258eFC52f9b7\"/" sequencer_config.json
#         ;;
#     2)
#         sed -i "s/\"0x6A568afe0f82d34759347bb36F14A6bB171d2CBe\"/\"0xaDef93B37f314ae8c8d711C76dB2C17587738DB8\"/" sequencer_config.json
#         sed -i "s/\"0xe2148eE53c0755215Df69b2616E552154EdC584f\"/\"0xcEeD7eFb59a5De0B885Af9b5D416bc5E9725C8e0\"/" sequencer_config.json
#         ;;
#     3)
#         sed -i "s/\"0x6A568afe0f82d34759347bb36F14A6bB171d2CBe\"/\"0xb911217f08f23e49F02151354c91c3f213C040CE\"/" sequencer_config.json
#         sed -i "s/\"0xe2148eE53c0755215Df69b2616E552154EdC584f\"/\"0x0831A8b22377779D19d014810754ceD6fC6b7dA0\"/" sequencer_config.json
#         ;;
#     *)
#         echo "Invalid option. Please use 1, 2, or 3 for the third parameter."
#         exit 1
#         ;;
# esac

# 替换A.json，B.json，C.json中的"deployed-at": 105
sed -i "s/\"deployed-at\": 105/\"deployed-at\": $number/" deployed_chain_info.json deployment.json l2_chain_info.json

echo "操作完成！"
