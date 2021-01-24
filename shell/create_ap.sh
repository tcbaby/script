#! /bin/sh
# author: tcbaby

sudo pacman -S create_ap

# 1. 直接开启
sudo create_ap wlp0s20f3 wlp0s20f3 mk qwertyui0p

# 2. 配置服务
# 修改 /etc/create_ap.conf 下面配置
if false; then
    WIFI_IFACE=wlp0s20f3
    INTERNET_IFACE=wlp0s20f3
    SSID=mk
    PASSPHRASE=qwertyui0p
fi

systemctl start create_ap


# err: Failed to initialize lock error
# sudo rm /tmp/create_ap.all.lock
