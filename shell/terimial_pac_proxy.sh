#!/bin/sh

sudo apt install privoxy

sudo cd /opt && sudo git clone https://github.com/zfl9/gfwlist2privoxy.git
sudo ln -sf /opt/gfwlist2privoxy/gfwlist2privoxy /usr/bin

# gfwlist file
gfwlist2privoxy 127.0.0.1:1080
sudo mv -f gfwlist.action /etc/privoxy/

# privoxy config
sudo mv /etc/privoxy/config /etc/privoxy/config.bak
sudo bach -c 'cat > /etc/privoxy/config << EOF
listen-address  127.0.0.1:8118
listen-address  [::1]:8118

forward-socks5   /               127.0.0.1:1080 .
actionsfile gfwlist.action
EOF'

sudo systemctl enable --now privoxy.service