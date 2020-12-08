#! /bin/bash

# sudo timedatectl set-local-rtc true
# ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# hwclock --systohc
# cat >> /etc/locale.gen <<eof
# en_US.UTF-8 UTF-8
# zh_CN.UTF-I UTF-8
# eof

sudo pacman-mirrors -i -c China -m rank
sudo pacman -Syy

if false
    [archlinuxcn]
    SigLevel = Optional TrustAll
    Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
    Server = https://repo.archlinuxcn.org/$arch
    Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
fi

sudo bash -c 'cat >> /etc/pacman.conf << EOF

[archlinuxcn]
SigLevel = Optional TrustAll
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch
EOF'

sudo pacman -Syy

# PGP签名
sudo pacman -S archlinux-keyring
# sudo pacman-key --populate archlinux manjaro
# sudo pacman-key --refresh-keys

sudo pacman -S vim code 
sudo pacman -S chromium proxychains typora
# sudo pacman -S electron-ssr
sudo sed -i 's/^#\(dynamic_chain\)/\1/' /etc/proxychains.conf
sudo sed -i 's/^socks4.*/socks5  127.0.0.1 1080/' /etc/proxychains.conf

sudo pacman -S firewalld net-tools nodejs npm
sudo systemctl enable --now firewalld

# tldr命令提示工具
sudo npm i -g nrm && nrm use cnpm
sudo npm i -g tldr &

# 开发工具
sudo pacman -S base-devel

# 搜狗输入法, 设置完成需要重启
# fcitx-im不行了,搜狗输入法不支持新版的fcitx-qt了
sudo pacman -S fcitx-lilydjwg-git fcitx-configtool fcitx-sogoupinyin
cat > ~/.xprofile << EOF
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
EOF

# vlc： [/](+/-)倍速播放； n/p：却换； f全屏
sudo pacman -S vlc flameshot

sudo pacman -S baidunetdisk-bin netease-cloud-music

# uget: 编辑->设置->插件, 在插件匹配顺序选择aria2
sudo pacman -S aria2 uget uget-integrator-chromium

# wechat, qq
sudo pacman -S electronic-wechat deepin.com.qq.office

# 安装wine ...
# sudo pacman -S wine wine-mono
# 打开wine设置
# env WINEPREFIX="$HOME/.deepinwine/Deepin-TIM" winecfg

# 安装wps
sudo pacman -S wps-office ttf-wps-fonts

# docker
sudo pacman -S docker
sudo systemctl enable --now docker

# 安装virtualbox
sudo pacman -S virtualbox
# 选择对应内黑的linux56-virtualbox-host-modules
# 将virtual模块添加到内核
sudo vboxreload

# 安装vmware && 对应内核的头文件
sudo pacman -S linux56-headers vmware-workstation

# 向内核加载vmw_vmci和vmmon模块
sudo modprobe --force-vermagic -a vmw_vmci vmmon
# 启动vmnet
sudo systemctl enable --now vmware-networks

echo "请重启系统!"

# s进入Manjaro Settings manager安装下字体。。
# 通过tweaktool设置字体书房1.21倍
