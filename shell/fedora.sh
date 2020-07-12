#! /bin/sh

# fastestmirror
echo fastestmirror=true >> /etc/dnf/dnf.conf
dnf clean all 
dnf makecache && dnf upgrade

# aliyun sources
wget -O /etc/yum.repos.d/fedora.repo http://mirrors.aliyun.com/repo/fedora.repo
wget -O /etc/yum.repos.d/fedora-updates.repo http://mirrors.aliyun.com/repo/fedora-updates.repo

# rpm fusion
sudo yum install --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# kernel header
sudo dnf -y install kernel-headers  # 安装kernel-headers
sudo dnf -y install kernel-devel    # 安装kernel-devel

sudo dnf -y install git 
sudo dnf -y install powertop flameshot

# typora图标
sudo bash -c 'cat > /usr/share/applications/typora.desktop << EOF
[Desktop Entry]
Name=typora
Version=0.9.9
Exec=/opt/typora/Typora
Comment=The Next Document processor based on Markdown
Icon=/opt/typora/resources/app/asserts/icon/icon_128x128.png
Type=Application
Terminal=false
StartupNotify=true
Encoding=UTF-8
Categories=Development;GTK;GNOME;
EOF'

# electronic wechat图标
sudo bash -c 'cat > /usr/share/applications/wechat.desktop << EOF
[Desktop Entry]
Name=Electronic Wechat
Exec=/opt/wechat/electronic-wechat %F
Icon=/opt/wechat/wechat.png
Terminal=false
X-MultipleArgs=false
Type=Application
Encoding=UTF-8
Categories=Application;Utility;Network;InstantMessaging;
StartupNotify=false
EOF'

# docker
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io
# 设置内核让其支持docker, 需要重启
sudo dnf -y install grubby
sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"

# echo GRUB_CMDLINE_LINUX="systemd.unified_cgroup_hierarchy=0" >> etc/default/grub
# sudo grub2-mkconfig -o  /boot/grub2/grub.cfg

sudo bash -c 'cat > /etc/docker/daemon.json << EOF
{
  "registry-mirrors" : [
    "http://ovfftd6p.mirror.aliyuncs.com",
    "http://registry.docker-cn.com",
    "http://docker.mirrors.ustc.edu.cn",
    "http://hub-mirror.c.163.com"
  ],
  "insecure-registries" : [
    "registry.docker-cn.com",
    "docker.mirrors.ustc.edu.cn"
  ],
  "debug" : true,
  "experimental" : true
}
EOF'