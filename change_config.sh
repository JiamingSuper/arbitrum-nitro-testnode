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

sed -i "s/\"url\": \"ws:\/\/geth:8546\"/\"url\": \"ws:\/\/$ip_address:8546\"/" sequencer_config.json
sed -i "s/ws:\/\/geth:8546/ws:\/\/$ip_address:8546/" ./scripts/index.ts

# 根据第三个参数进行不同的替换操作
case $option in
    1)
        sed -i "s/\"0x46225F4cee2b4A1d506C7f894bb3dAeB21BF1596\"/\"ABC\"/" sequencer_config.json
        sed -i "s/\"0x19ED240ddd4DDEeDdF2B77aA279F258eFC52f9b7\"/\"ABCD\"/" sequencer_config.json
        ;;
    2)
        sed -i "s/\"0xaDef93B37f314ae8c8d711C76dB2C17587738DB8\"/\"BCD\"/" sequencer_config.json
        sed -i "s/\"0xcEeD7eFb59a5De0B885Af9b5D416bc5E9725C8e0\"/\"BCEDE\"/" sequencer_config.json
        ;;
    3)
        sed -i "s/\"0xb911217f08f23e49F02151354c91c3f213C040CE\"/\"12345\"/" sequencer_config.json
        sed -i "s/\"0x0831A8b22377779D19d014810754ceD6fC6b7dA0\"/\"123456\"/" sequencer_config.json
        ;;
    *)
        echo "Invalid option. Please use 1, 2, or 3 for the third parameter."
        exit 1
        ;;
esac

# 替换A.json，B.json，C.json中的"deployed-at": 105
sed -i "s/\"deployed-at\": 105/\"deployed-at\": $number/" deployed_chain_info.json deployment.json l2_chain_info.json

echo "操作完成！"
