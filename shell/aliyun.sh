#! /bin/sh
# centos7

# 删除aliyun登录界面欢迎信息
echo > /etc/motd

# 卸载阿里云盾
wget http://update.aegis.aliyun.com/download/uninstall.sh && sh uninstall.sh
wget http://update.aegis.aliyun.com/download/quartz_uninstall.sh && sh quartz_uninstall.sh

sudo pkill aliyun-service
sudo rm -rf /etc/init.d/agentwatch /usr/sbin/aliyun-service
sudo rm -rf /usr/sbin/aliyun*
sudo rm -rf /etc/systemd/system/aliyun.service
sudo rm -rf /usr/local/aegis*

# iptables -I INPUT -s 140.205.201.0/28 -j DROP
# iptables -I INPUT -s 140.205.201.16/29 -j DROP
# iptables -I INPUT -s 140.205.201.32/28 -j DROP
# iptables -I INPUT -s 140.205.225.192/29 -j DROP
# iptables -I INPUT -s 140.205.225.200/30 -j DROP
# iptables -I INPUT -s 140.205.225.184/29 -j DROP
# iptables -I INPUT -s 140.205.225.183/32 -j DROP
# iptables -I INPUT -s 140.205.225.206/32 -j DROP
# iptables -I INPUT -s 140.205.225.205/32 -j DROP

# 删除云监控
/usr/local/cloudmonitor/CmsGoAgent.linux-amd64 stop && \
/usr/local/cloudmonitor/CmsGoAgent.linux-amd64 uninstall && \
rm -rf /usr/local/cloudmonitor