#!/bin/sh

# 链接配置文件
sudo ln -sf /usr/local/shadowsocksr/config.json /etc/shadowsocksr.json

# 创建ssr服务脚本
sudo bash -c 'cat > /etc/systemd/system/shadowsocksr.service << EOF
[Unit]
Description=shadowsocksr
[Service]
ExecStart=python /usr/local/shadowsocksr/shadowsocks/local.py -c /etc/shadowsocksr.json
[Install]
WantedBy=multi-user.target
EOF'

# 设置开机自启动
systemctl enable --now shadowsocksr
