#!/bin/sh

mkdir /opt
mkdir /opt/fast
cd /opt/fast
curl --retry 10 --retry-max-time 60 -H "Cache-Control: no-cache" -fsSL github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip -o /opt/fast/dist.zip
busybox unzip /opt/fast/dist.zip
rm -rf /opt/fast/dist.zip
mv /opt/fast/v2ray /opt/fast/core

cat << EOF > /opt/fast/config.json
{
    "inbounds": [{
        "port": ${PORT},
        "protocol": "vmess",
        "settings": {
            "clients": [{
                "id": "${ID}",
                "alterId": ${AID}
            }]
        },
        "streamSettings": {
            "network": "ws",
            "wsSettings": {
                "path": "${WSPATH}"
            }
        }
    }],
    "outbounds": [{
        "protocol": "freedom"
    }]
}
EOF

ln -s /opt/fast/core /usr/bin/core
chmod +x /usr/bin/core
core -config /opt/fast/config.json
