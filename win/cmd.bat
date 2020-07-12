

# 查看进程
tasklist | findstr cmd
# 杀死进程      将'/'换成'-'即可在git bash中使用
taskkill /F /PID 进程id         # -F强制杀死    -PID 指定进程ID
taskkill /F /IM cmd*            # -IM 指定进程的映像名称，可使用通配符*


# 挂载非window磁盘
# 要用管理员身份打开终端
c:\>diskpart
list disk           # 磁盘列表
select disk n       # 选择EFI分区所在的磁盘，n为磁盘号
list partition      # 磁盘分区列表
select partition n  # 选择EFI分区，n为EFI分区号
set id="ebd0a0a2-b9e5-4433-87c0-68b6b72699c7"	# 设置为基本数据分区
assign letter=X     # x为EFI分区盘符
remove letter=X     # 删除X盘符