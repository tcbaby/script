
FROM    以哪个镜像为基础开始构建.
MAINTAINER  作者信息.

WORKDIR RUN, CMD, ENTRYPOINT 这些命令执行时的当前目录.

ADD     从当前目录复制文件到容器. 会自动处理目录, 压缩包等情况.
COPY    从当前目录复制文件到容器. 只是单纯地复制文件.

ENV     设置环境变量

VOLUME  声明一个数据卷, 可用于挂载.

RUN   运行一条命令.

CMD   docker run IMAGE_ID cmd 这里的默认命令.
ENTRYPOINT  docker run IMAGE_ID cmd 这里的默认命令的前面部分, run 中 cmd 可以作为后续参数.

EXPOSE  声明会用到的端口.

USER    RUN 命令执行时的用户.

ONBUILD     前缀命令, 放在上面这些命令前面, 表示生成的镜像再次作为"基础镜像"被用于构建时, 要执行的命令.

# docker build -f [dockerfile] -t [tag] .