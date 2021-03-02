#!/bin/sh

sudo apt update

sudo apt-get -y remove docker docker-engine docker.io containerd runc

sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt update

sudo apt-get -y install docker-ce docker-ce-cli containerd.io

sudo bash -c 'cat > /etc/docker/daemon.json << EOF
{
  "registry-mirrors" : [
    "http://ovfftd6p.mirror.aliyuncs.com",
    "http://registry.docker-cn.com",
    "http://docker.mirrors.ustc.edu.cn",
    "http://hub-mirror.c.163.com"
  ],
  "insecure-registries" : [
    "registry.docker-cn.com",
    "docker.mirrors.ustc.edu.cn"
  ],
  "debug" : true,
  "experimental" : true
}
EOF'

sudo systemctl enable --now docker


sudo docker run -d --name es_temp --restart=always \
    -v /usr/local/es_temp/config/:/usr/share/elasticsearch/config/ \
    -v /usr/local/es_temp/data/:/usr/share/elasticsearch/data/ \
    --net=host elasticsearch:5.2.0