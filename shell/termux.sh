pkg i                           # 安装软件
pkg update                      # 更新源
pkg upgrade                     # 升级软件包
pkg list-all                    # 列出可供安装的所有包
pkg list-installed              # 列出已经安装的包
pkg shoe <package>              # 显示某个包的详细信息
pkg files <package>             # 显示某个包的相关文件夹路径


# 更换国内源： http://mirrors.tuna.tsinghua.edu.cn/termux
vi  $PREFIX/etc/apt/sources.list


# 安装软件
pkg i -y vim curl wget git openssh

# 模拟root
pkg i -y proot
termux-chroot

# tsu
pkg i -y tsu
tsu


# install linux OS
wget http://funs.ml/file/atilo && chmod +x atilo && ./atilo


# zsh
sh -c "$(curl -fsSL https://github.com/Cabbagec/termux-ohmyzsh/raw/master/install.sh)"  
~/termux-ohmyzsh/install.sh                             # 选背景色和字体
sed -i 's/ZSH_THEME=.*/ZSH_THEME="cloud"/g' ~/.zshrc    # 修改主题
. ~/.zshrc# 写入特殊字符时，需要使用反斜杠进行转义(如:\$)
cat > file << eof
    ...
eof