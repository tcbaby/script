FROM centos
MAINTAINER tcbaby <cbtan@foxmail.com>

# ADD ./tools/jdk-8u131-linux-x64.tar.gz /usr/local/
# ADD ./tools/apache-tomcat-9.0.41.tar.gz /usr/local/

RUN cd /usr/local; \
    yum -y install wget; \
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
        http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz; \
    wget https://mirror.bit.edu.cn/apache/tomcat/tomcat-9/v9.0.41/bin/apache-tomcat-9.0.41.tar.gz; \
    tar zxvf jdk-8u131-linux-x64.tar.gz; \
    tar zxvf apache-tomcat-9.0.41.tar.gz; \
    mv jdk1.8.0_131 jdk1.8; \
    mv apache-tomcat-9.0.41 tomcat; \
    rm -f bin/*bat *tar.gz*; \
    cd tomcat; \
    mv webapps webapps.bak; \
    mkdir webapps; \
    chmod -R 7777 logs webapps

WORKDIR /usr/local/tomcat
VOLUME /usr/local/tomcat/webapps /usr/local/tomcat/logs

# jdk
ENV JAVA_HOME /usr/local/jdk1.8
ENV JRE_HOME ${JAVA_HOME}/jre
ENV CLASSPATH .:${JAVA_HOME}/lib:${JRE_HOME}/lib
ENV JAVA_PATH ${JAVA_HOME}/bin:${JRE_HOME}/bin
# tomcat
ENV CATALINA_HOME /usr/local/tomcat
ENV JPDA_ADDRESS 0.0.0.0:8000
ENV JAVA_OPTS -server -Xms1g -Xmx2g -Djava.awt.headless=true -XX:+UseConcMarkSweepGC  -XX:+UseParNewGC  -XX:+CMSParallelRemarkEnabled  -Xloggc:/tmp/gc.log  -XX:GCLogFileSize=10M -XX:NumberOfGCLogFiles=10 -XX:+UseGCLogFileRotation -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+PrintGCDetails -XX:+DisableExplicitGC -verbose:gc -Dfile.encoding=UTF-8
# path
ENV PATH $PATH:${JAVA_PATH}:$CATALINA_HOME/bin

EXPOSE 8080 8000
CMD catalina.sh jpda run