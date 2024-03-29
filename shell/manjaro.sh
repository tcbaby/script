#! /bin/bash
# by tcbaby
# for manjaro linux

# sudo timedatectl set-local-rtc true
# ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# hwclock --systohc
# cat >> /etc/locale.gen <<eof
# en_US.UTF-8 UTF-8
# zh_CN.UTF-I UTF-8
# eof

#sudo pacman-mirrors -i -c China -m rank
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sudo bach -c 'cat > /etc/pacman.d/mirrorlist << EOF
# 中科大
Server = https://mirrors.ustc.edu.cn/manjaro/stable/$repo/$arch
# 清华源
Server = https://mirrors.tuna.tsinghua.edu.cn/manjaro/stable/$repo/$arch
# 上交源
Server = https://mirrors.sjtug.sjtu.edu.cn/manjaro/stable/$repo/$arch
# 浙大源
Server = https://mirrors.zju.edu.cn/manjaro/stable/$repo/$arch
EOF'

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

# AUR
sudo pacman -S yay
yay --aururl "https://aur.tuna.tsinghua.edu.cn" --save

# xflux 自动改变显示屏的颜色
pacman -S xflux
xflux -l 29.59 -g 106.54

# devtool
sudo pacman -S net-tools base-devel cmake extra-cmake-modules

# krunner-vscodeprojects JetBrainsRunner lib
# sudo pacman -S packagekit-qt5 libnotify kcmutils kio
# curl https://raw.githubusercontent.com/alex1701c/krunner-vscodeprojects/master/install.sh | bash
# curl https://raw.githubusercontent.com/alex1701c/JetBrainsRunner/master/install.sh | bash

# firewalld
sudo pacman -S firewalld
sudo systemctl enable --now firewalld

# proxy
sudo pacman -S proxychains electron-ssr
sudo sed -i 's/^#\(dynamic_chain\)/\1/' /etc/proxychains.conf
sudo sed -i 's/^socks4.*/socks5  127.0.0.1 1080/' /etc/proxychains.conf

# editor
# gvim "+y +clipboard
# sudo pacman -S gvim
sudo pacman -S code typora 

# uget: 编辑->设置->插件, 在插件匹配顺序选择aria2
# sudo pacman -S chromium aria2 uget uget-integrator-chromium
sudo pacman -S google-chrome aria2 uget uget-integrator-chrome

# 安装小企鹅输入法, 安装完成后需要注销重新登录
yay -S fcitx-lilydjwg-git 
pacman -S fcitx-googlepinyin fcitx-cloudpinyin fcitx-configtool
#yay -S fcitx-sogoupinyin
cat > ~/.xprofile << EOF
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
EOF

# rdp
sudo pacman -S freerdp krdc

# vlc： [/](+/-)倍速播放； n/p：却换； f全屏
sudo pacman -S vlc flameshot

sudo pacman -S baidunetdisk-bin netease-cloud-music

# wechat, qq
sudo pacman -S electronic-wechat 
yay -S  com.qq.tim.spark

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
