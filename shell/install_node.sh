#!/bin/sh
# by tcbaby
# for manjaro 

sudo pacman -S nodejs npm
npm config set registry https://registry.npm.taobao.org

# glolbal dir
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo export NPM_CONFIG_PREFIX=~/.npm-global >> ~/.bashrc
. ~/.bashrc

# tldr命令提示工具
npm i -g nrm tldr
