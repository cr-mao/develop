## mysql


### 二进制安装、及配置、启动脚本

```shell
sudo wget https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.35-linux-glibc2.12-x86_64.tar.gz
```

my.cnf => /etc/my.cnf 配置文件 5.7.35

mysql.server => /etc/init.d/mysql.server   (systemctl service 文件,已经做了一定修改)
- sudo systemctl start mysql 



### Xtrlabackup备份及恢复



#### 全量备份及恢复
```shell
sudo wget https://downloads.percona.com/downloads/Percona-XtraBackup-2.4/Percona-XtraBackup-2.4.27/binary/tarball/percona-xtrabackup-2.4.27-Linux-x86_64.glibc2.12.tar.gz

tar zxvf percona-xtrabackup-2.4.27-Linux-x86_64.glibc2.12.tar.gz

mv percona-xtrabackup-2.4.27-Linux-x86_64.glibc2.12 /opt/xtrabackup


# 全量备份
sudo /opt/xtrabackup/bin/innobackupex --user=root --password=`yourpassword` /opt/xtrabackup/bakdir

# 停mysqld
sudo systemctl stop mysql 

# 原来的目录不能为空
sudo mv /db/data /db/data_bak 

# 制定恢复的dir 路径
sudo /opt/xtrabackup/bin/innobackupex --copy-back  /opt/xtrabackup/bakdir/2022-12-12_03-46-34
# 用这个
sudo /opt/xtrabackup/bin/innobackupex --defaults-file=/etc/my.cnf --user=root --password=`yourpassword` --copy-back  /opt/xtrabackup/bakdir/2022-12-12_03-46-34

sudo systemctl start mysql  # 报错 the server quit without updating PID file 

#修改权限 
sudo chown -R mysql:mysql /db/data

sudo systemctl start mysql

```


#### 增量备份

```shell
innobackupex --user=root --password=123456 --incremental bakdir/ --incremental-basedir='/opt/xtrabackup/bakdir/2022-12-10_10-43-09(全量路径)' #基于这个进行增量
# bakdir 指定备份到哪个目录
```

#### 增量备份合并到全量备份
```shell
innobackupex --apply-log  全量路径 --incremental-dir=增量备份路径(bakdir/YYYY-YY-YY)
```



