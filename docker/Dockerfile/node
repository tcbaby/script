FROM centos
MAINTAINER tcbaby <cbtan@foxmail.com>

RUN yum -y install nodejs; \ 
    npm config set registry https://registry.npm.taobao.org; \
    mkdir /project && cd /project; \
    echo '{"scripts":{"dev":"node app.js"}}' > package.json; \
    echo 'console.log("Hello Node")' > app.js
    
WORKDIR /project
VOLUME /project

CMD npm i; npm run dev

# tips: 使用 host 网络创建容器
# docker run -d --name [name] --network=host -v [project dir]:/project [image]