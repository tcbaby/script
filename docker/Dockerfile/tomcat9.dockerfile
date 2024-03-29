FROM centos
MAINTAINER tcbaby <cbtan@foxmail.com>

# ADD ./tools/jdk-8u131-linux-x64.tar.gz /usr/local/
# ADD ./tools/apache-tomcat-9.0.41.tar.gz /usr/local/

RUN cd /usr/local; \
    yum -y install wget; \
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
        http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz; \
    wget https://apache.website-solution.net/tomcat/tomcat-9/v9.0.43/bin/apache-tomcat-9.0.43.tar.gz; \
    tar zxvf jdk-8u131-linux-x64.tar.gz; \
    tar zxvf apache-tomcat-9.0.41.tar.gz; \
    mv jdk1.8.0_131 jdk1.8; \
    mv apache-tomcat-9.0.41 tomcat; \
    rm -f bin/*bat *tar.gz*; \
    cd tomcat; \
    mv webapps webapps.bak; \
    mkdir webapps; \
    mkdir -p logs/app; \
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
# path
ENV PATH $PATH:${JAVA_PATH}:$CATALINA_HOME/bin

EXPOSE 8080
CMD catalina.sh run
