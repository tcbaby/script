#! /bin/sh
# system: cnetos
# author: tcbaby

version=5.6.16
if [ $1 ]; then
    version=$1
fi
echo Download elasticsearch version $version.

# firewall
sudo firewall-cmd --permanent --add-port=5601/tcp
sudo firewall-cmd --permanent --add-port=9200/tcp
sudo firewall-cmd --permanent --add-port=9300/tcp
sudo firewall-cmd --permanent --zone=trusted --change-interface=docker0
sudo firewall-cmd --permanent --zone=trusted --add-port=5601/tcp
sudo firewall-cmd --reload

# elasticsearch
sudo docker pull elasticsearch:${version}
sudo docker run -d --name es -p9200:9200 -p9300:9300 -e "discovery.type=single-node" -e "ES_JAVA_OPTS=-Xms512m -Xmx512m" elasticsearch:${version}

# kibana
sudo docker pull kibana:${version}
sudo docker run -d --name kibana -p5601:5601 --link es:elasticsearch kibana:${version}
# sudo docker run -d --name kibana_t -p7602:5601 -e ELASTICSEARCH_URL=http://10.0.0.53:7201 kibana:5.2.0

# ik plugin
#elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v${version}/elasticsearch-analysis-ik-${version}.zip
cd ~/Download
if [ ! -f elasticsearch-analysis-ik-${version}.zip ]; then
    wget https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v${version}/elasticsearch-analysis-ik-${version}.zip
    rm -rf ik
fi
unzip elasticsearch-analysis-ik-${version}.zip
mv elasticsearch ik
sudo docker cp ik es:/usr/share/elasticsearch/plugins
sudo docker restart es

# uninstall
#sudo docker stop es kibana && sudo docker rm es kibana
#sudo docker rmi -f elasticsearch:${version} kibana:${version}