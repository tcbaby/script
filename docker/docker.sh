#! /bin/sh

# nginx
sudo docker pull nginx:latest
sudo docker run --name nginx -v /d/workspace/script/config/nginx.conf:/etc/nginx/nginx.conf -p80:80 -d nginx

# redis
sudo docker pull redis:latest
sudo docker run --name redis -v /d/workspace/script/config/redis.conf:/etc/redis/redis.conf -p6379:6379 -d redis

# mongo
sudo docker run -d --name mongo -p27017:27017 --restart=always mongo --auth
#sudo docker exec mongo mongo admin
#db.createUser({ user:'tcb',pwd:'qw@rtyui0p',roles:[ { role:'userAdminAnyDatabase', db: 'admin'},"readWriteAnyDatabase"]});

# mysql 注意：启动mysql容器后，需要重启一次方可连接成功
sudo docker pull mysql:latest
sudo docker run --name mysql -e MYSQL_ROOT_PASSWORD=Tan12345 -p3306:3306 -d mysql

# oracle
sudo docker load < /d/packge/Oracle11g/docker-oracle11g.tar.gz
sudo docker run --name oracle --env NLS_LANG=AMERICAN_AMERICA.UTF8 -p 1521:1521 -d rodrigozc/oracle11g

# fastdfs
# sudo docker pull season/fastdfs
# sudo docker run -d --name tracker -v ~/temp/fastdfs/tracker_data:/fastdfs/tracker/data --net=host season/fastdfs tracker
# sudo docker run -d --name storage -v ~/temp/fastdfs/storage_data:/fastdfs/storage/data -v ~/temp/fastdfs/store_path:/fastdfs/store_path --net=host -e TRACKER_SERVER:192.168.1.11:22122 season/fastdfs storage

# rabbitmq
docker pull rabbitmq:management   # 该版本含有web管理界面 端口15672
# 默认账号密码guest, 可以使用 -e RABBITMQ_DEFAULT_USER=user -e RABBITMQ_DEFAULT_PASS=password
docker run -d --hostname rabbit --name rabbit -p 15672:15672 -p 5672:5672 rabbitmq:management

# 重启容器
sudo docker restart $(docker ps -aq)

# 开放docker bridge网络
sudo firewall-cmd --permanent --add-rich-rule="rule family="ipv4" source address="172.17.0.1/16" port port="0-65535" protocol="tcp" accept"
sudo firewall-cmd --reload

# docker四种网络模式
# bridge默认， 
# host，共享主机ip
# none， Docker容器拥有自己的Network Namespace，但是，并不为Docker容器进行任何网络配置。也就是说，这个Docker容器没有网卡、IP、路由等信息。需要我们自己为Docker容器添加网卡、配置IP等。
# container，这个模式指定新创建的容器和已经存在的一个容器共享一个Network Namespace，而不是和宿主机共享

# 显示容器相关信息
# docker inspect 容器

# 重启docker服务后自动启动容器
# docker update --restart=always <CONTAINER ID>

# sudo docker system df           # 查看docker占用空间
# sudo docker system prune        # 删除文件