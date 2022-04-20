#!/bin/sh
# author: tcbaby

wget https://nodejs.org/dist/v16.14.2/node-v16.14.2-linux-x64.tar.xz
tar Jxvf node-v16.14.2-linux-x64.tar.xz && mv node-v16.14.2-linux-x64 /usr/local/nodejs
ln -sf /usr/local/nodejs/bin/* /usr/bin/
rm -f node-v16.14.2-linux-x64.tar.xz

# glolbal dir
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo export NPM_CONFIG_PREFIX=~/.npm-global >> ~/.bashrc
. ~/.bashrc

# tldr命令提示工具
npm i -g nrm tldr
