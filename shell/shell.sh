
# 内置变量
$0      # 脚本名
$n      # 位置参数
$#      # 位置参数的个数
$@      # 所有位置参数，每个参数作为一个独立的字符串
$*      # 所有位置参数，作为一个字符串


# if else
if [ ]; then
    echo 
elif [ ]; then
    echo
else
    echo
fi

# for
for i in 1 2 3; do echi $i; done
for i in `seq 1 10`; do echo $i; done
for file in ./*; do  echo $file; done

# while
 while read line
 do 
    echo $line; 
 done < file


# 写入特殊字符时，需要使用反斜杠进行转义(如:\$)
cat > file << eof
    ...
eof

# 在文件末尾追加内容， (\ + enter)换行
sed -i '$a ...' file
# 替换 支持正则表达式
sed -i 's/old/new/' file 
# 删除匹配行
sed -i '/reg/d' file

# err: $'\r': command not found. 无法识别windows下的回车符
# :set fileformat=unix
