#! /bin/sh
# /etc/ssh/ssh_config   /   ~/.ssh/config

# 客户端设置保存连接
sudo bash -c 'cat >> /etc/ssh/ssh_config << eof
host *
    TCPKeepAlive=yes
    # Client每隔 60 秒发送一次请求给 Server，然后 Server响应，从而保持连接
    ServerAliveInterval 60
    # Client发出请求后，服务器端没有响应得次数达到3，就自动断开连接。
    ServerAliveCountMax 3
eof'


# 服务器端设置保存连接
sudo bash -c 'cat >> /etc/ssh/ssh_config << eof
host *
    # Server 每隔 60 秒发送一次请求给 Client，然后 Client响应，从而保持连接
    ClientAliveInterval 60
    # Server发出请求后，客户端没有响应得次数达到 10，就自动断开连接，正常情况下，Client不会不响应
    ClientAliveCountMax 10
eof'


# 连接时指定
# $ ssh -o ServerAliveInterval=60 user@host