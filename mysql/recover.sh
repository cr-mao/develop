#!/bin/bash


#全量备份目录
back_dir="/opt/xtrabackup/bakdir/"
# 全部备份目录,最后一个就是最新的备份目录
all_back_dir=`ls  $back_dir | tail -n 1`


# 恢复脚本
systemctl stop mysql
mv /db/data /db/data_bak
# /db/data 它自己会创建出来
/opt/xtrabackup/bin/innobackupex --defaults-file=/etc/my.cnf --user=root --password=`yourpassword` --copy-back  $back_dir/$all_back_dir
# 修改数据权限为mysql，很关键，不然mysql启动报错
chown -R mysql:mysql /db/data
systemctl start mysql
