-- redhat/centos安装mariadb
yum install mariadb mariadb-server
systemctl start mariadb         #启动mariadb
systemctl enable mariadb        #设置开机自启动
mysql_secure_installation       #设置root密码、远程访问等信息
mysql -uroot -p                 #登录

-- mariadb默认密码为空
-- 刚安装完mariadb后使用mysql_secure_installation脚本，在第一步输入密码可能会失败，可以重启系统再次进行配置


-- 远程/代码控制数据乱码
SHOW VARIABLES LIKE 'character%';   -- 查看系统默认字符集
SHOW VARIABLES LIKE 'collation_%';  
-- 修改编码: 使用mysql命令
SET NAMES 'utf8';       -- 修改client、connection、results 三个字符集
SET character_set_database = utf8 ;
SET character_set_server = utf8 ;

-- 修改编码：该配置文件
vim /etc/my.cnf        
# 在[mysqld]标签下添加下面内容
default-storage-engine = innodb
innodb_file_per_table
max_connections = 4096
collation-server = utf8_general_ci
character-set-server = utf8

vim /etc/my.cnf.d/client.cnf
# 在[client]标签下添加下面内容
default-character-set=utf8

vim /etc/my.cnf.d/mysql-clients.cnf
# 在[mysql]标签下添加下面内容
default-character-set=utf8

-- 设置好字符集后，连接数据库时候，应该指定编码，比如使用jdbc连接时，指定连接为utf8方式.


-- DCL：管理用户，授权
    -- 管理用户
        -- 添加用户
        CREATE USER '用户名'@'主机名' IDENTIFIED BY '密码';
        -- 删除用户
        DROP USER '用户名'@'主机名';           
        -- 更改密码           
        UPDATE USER SET PASSWORD = PASSWORD('新密码') WHERE USER = '用户名';
        SET PASSWORD FOR '用户名'@'主机名' = PASSWORD('新密码');

        -- 查询用户；mysql.user表中
        USE myql;
        SELECT user, password, host FROM USER;

    -- 权限管理：
        -- 查询权限
        SHOW GRANTS FOR '用户名'@'主机名';
        SHOW GRANTS FOR 'lisi'@'%';

        -- 授予权限：
        grant 权限列表 on 数据库名.表名 to '用户名'@'主机名';
        -- 给张三用户授予所有权限，在任意数据库任意表上
        GRANT ALL ON *.* TO 'zhangsan'@'localhost';
        -- 撤销权限：
        revoke 权限列表 on 数据库名.表名 from '用户名'@'主机名';

        -- 例子: 创建tt用户，并授予最高权限
        create user 'tcb'@'%' identified by 'Tan12345';
        grant all privileges on *.* to 'tcb'@'%';

    -- 开放其他主机远程连接数据库权限
        -- mysql.user表中记录着权限分配（用户，对应客户端主机）
        -- 赋予用户在指定主机上连接数据库，并赋予相应权限。
        grant 权限列表 privileges on *.* to [username]@"[host]" identified by "[password]"; 

        -- 例：允许用户root使用密码root在任何主机上连接该数据库，并赋予该用户所有权限。
            1. 服务器开3306端口 
            firewall-cmd --add-port=3306/tcp --permanent
            firewall-cmd --reload
            2. 进入数据库授予用户权限
            grant all privileges on *.* to root@"%" identified by "root"    -- %通配符代表任意主机


-- 数据库操作
    select version();                       -- 显示数据库版本

    select now();                           -- 显示时间

    show databases;                         -- 查看所有数据库

    select database();                      -- 查看当前使用的数据库

    use 数据库名;                           -- 使用数据库

    create database 数据库名 charset=utf8;  -- 创建数据库

    show create database 数据库名;          -- 查看创建数据库的语句    

    drop database 数据库名;                 -- 删除数据库


-- 数据表的操作

    -- 查看当前数据库中所有表
    show tables;

    -- 查看表结构
    desc 表名;

    -- 查看表的创建语句
    show create table 表名;

    -- 创建表
    -- create table 数据表名字 (字段 类型 约束, ...);
    -- 约束：auto_increment表示自动增长(插入数据时可以使用0 / default占位)、 not null、 primary key、default
    create table students (
        id bigint unsigned not null auto_increment primary key,
        name varchar(30) not null, 
        age tinyint unsigned default 0,
        high decimal(5,2),      -- 规定存储的值不超过5位数，且小数点后面有2位数字
        gender enum("男", "女") default "女"
    );

    -- 插入数据
    insert [into] 表名 values(...)
    insert [into] 表名(列名,...) values(...)
    insert [into] 表名(列名,...) values(...), (...) ... -- 插入多列

    --- 修改
    update 表名 set 列1=值1,列2=值2... where 条件;

    -- 物理删除
    delete from 表名 where 条件

    -- 逻辑删除： 用一个字段来表示 这条信息是否已经不能再使用了
    -- 如：给表添加一个is_delete字段[bit(1)], 为true表示改行信息不在使用
    alter table 表名 add is_delete bit(1) default 0;
    update 表名 set is_delete=1 where 条件;     -- 修改标记


-- 查询
    select 字段[as 别名] , 字段[as 别名] from 数据表 where ....;

    -- like模糊查询: 效率低。 %替换任意个字符， _替换一个字符
    select name from students where name like "小%";

    -- rlike 查询中使用正则
    select name from students where name rlike "^小.*"; 

    -- 范围查询
    -- in (), not in(), between ... and ..., not between ... and ...
    select name from students where age in (1, 2, 3);
    select * from students where age between 18 and 34;

    -- 空判断: is null, is not null
    select * from students where high is null;


    -- 排序
    -- order by 字段1 [asc(默认升序) / desc(降)], 字段2 [] ...
    select * from students order by age asc, height desc;


    -- 聚合函数
    -- count(*)总数， max()最大值， min(), sum(), avg(), round(数, 精度)四舍五入
    select round(avg(height), 2) from students where gender=2;     -- 男性的平均身高 保留2位小数


    -- 分组
    -- group by 字段


    -- 分组
        -- group by
        -- 在students表中，按照性别分组,查询所有的性别
        -- 失败select * from students group by gender;
        select gender from students group by gender;

        -- 在students表中，计算每种性别中的人数
        select gender,count(*) from students group by gender;

        -- 在students表中，计算男性的人数
        select count(*) from students where gender=1;
        select gender,count(*) from students where gender=1 group by gender;

        -- group_concat(...)
        -- 在students表中，查询男性中的姓名
        select gender, group_concat(name) from students where gender=1 group by gender;
        | gender | group_concat(name) |
        +--------+--------------------+
        | 男     | tt1,tt2            |
        +--------+--------------------+

        -- having
        -- 在students表中，按照性别分组，查询平均年龄超过30岁的性别，以及姓名 having avg(age) > 30
        select gender, group_concat(name), avg(age) from students group by gender having avg(age)>30;
        
        -- 在students表中，查询每种性别中的人数多于2个的信息
        select gender, group_concat(name), count(*) from students group by gender having count(*)>2;


    -- 分页
        -- limit offset, size    从哪儿开始 每页显示个数        使用在where、order、having后

        -- 在students表中，查询前5个数据    offset=0省略
        select * from students limit 5;

        -- limit (第N页-1)*每页的个数, 每页的个数
        -- 在students表中，每页显示2个，第1个页面
        select * from students limit 0, 2;
        -- 在students表中，每页显示2个，第2个页面
        select * from students limit 2, 2;
        -- 在students表中，每页显示2个，第3个页面
        select * from students limit 4, 2;

        -- 在students表中，查询女性信息 并且按照身高从高到矮排序 只显示前2个
        select * from students where gender=2 order by height desc limit 0,2;


-- 连接查询
    -- inner join ... on    等值连接/内连接：只返回两个表中连接字段相等的行。
    -- select ... from 表A inner join 表B;

    -- 查询 有能够对应班级的学生以及班级信息
    select * from students inner join classes on students.cls_id=classes.id;

    -- 给数据表起名字   
    -- 查询 有能够对应班级的学生以及班级信息，显示学生的所有信息，只显示班级名称
    select s.*, c.name from students as s inner join classes as c on s.cls_id=c.id;

    -- 查询 有能够对应班级的学生以及班级信息, 并排序（先按班级进行排序，班级内按学生id排序）。
    select c.name , s.* from students as s inner join classes as c on s.cls_id=c.id order by c.name, s.id;

    -- left join        左连接：返回左表中的所有记录和右表中连接字段相等的记录，不相等的记录的所有字段用null填充。
    -- 查询每位学生对应的班级信息
    select * from students as s left join classes as c on s.cls_id=c.id;

    -- 查询没有对应班级信息的学生
    -- select ... from xxx as s left join xxx as c on..... where/having .....
    select * from students as s left join classes as c on s.cls_id=c.id where c.id is null;

    -- right join       右连接：返回右表中所有记录和...
    -- 将数据表名字互换位置，用left join完成

-- 自关联
    -- 例：实现省级联动 url: http://demo.lanrenzhijia.com/2014/city0605/

    -- 创建areas表
    create table areas(
        aid int primary key,
        atitle varchar(20),
        pid int
    );
    -- 导入数据
    source areas.sql

    -- 查询所有省份
    select * from areas where pid is null; 

    -- 查询出山东省有哪些市
    select * from areas as province inner join areas as city on city.pid=province.aid having province.atitle="山东省";
    select province.atitle, city.atitle from areas as province inner join areas as city on city.pid=province.aid having province.atitle="山东省";

    -- 查询出青岛市有哪些县城
    select province.atitle, city.atitle from areas as province inner join areas as city on city.pid=province.aid having province.atitle="青岛市";
    select * from areas where pid=(select aid from areas where atitle="青岛市")  -- 子查询


-- 子查询   效率极低
    -- 标量子查询
    -- 查询出高于平均身高的信息
    select * from students where height > (select avg(height) from students);

    -- 查询最高的男生信息
    select * from students where height = (select max(height) from students);

    -- 列级子查询
    -- 查询学生的班级号能够对应的学生信息
    select * from students where cls_id in (select id from classes);


-- 空值处理
    ifnull(col, value);
    select * from emp order by ifnull(comm, -1);


-- 关闭自动提交
    set autocommit = 0;
-- 手动提交
    commit;