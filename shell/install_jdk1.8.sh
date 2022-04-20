#! /bin/sh
# author: tcbaby

wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz

tar zxvf jdk-8u131-linux-x64.tar.gz
mkdir /usr/local/java
mv jdk1.8.0_131/ /usr/local/java/jdk1.8
rm -f jdk-8u131-linux-x64.tar.gz

# jdk1.8
sed -i '$a \
\
# jdk8\
export JAVA_HOME=/usr/local/java/jdk1.8\
export JRE_HOME=${JAVA_HOME}/jre\
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib:$CLASSPATH\
export JAVA_PATH=${JAVA_HOME}/bin:${JRE_HOME}/bin\
export PATH=$PATH:${JAVA_PATH}' /etc/profile

. /etc/profile