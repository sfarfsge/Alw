#!/bin/bash

rm -f web config.json
wget -N https://raw.githubusercontent.com/sfarfsge/Alw/main/web
chmod +x ./web

if [[ -z $id ]]; then
    id="5aaed9b7-7fe3-47c3-bb52-db59859ce198"
fi

cat <<EOF > ~/config.json
{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$id"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

./web -config=config.json
