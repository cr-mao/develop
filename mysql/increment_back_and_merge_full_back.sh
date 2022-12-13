#!/bin/bash

# 增量备份，并合并到全量备份中

#全量备份目录
back_dir="/opt/xtrabackup/bakdir/"
# 增量备份目录
increment_back_dir="/opt/xtrabackup/incrementdir"
# 全部备份目录,最后一个就是最新的备份目录
all_back_dir=`ls  $back_dir | tail -n 1`
#echo $all_back_dir >> bak_info.txt 2>&1

# 进行增量备份
/opt/xtrabackup/bin/innobackupex --user=root --password=xxxxx --incremental $increment_back_dir --incremental-basedir=$back_dir/$all_back_dir


# 最后一个增量的文件
last_increment_back_dir=`ls $increment_back_dir | tail -n 1`
#echo $last_increment_back_dir >> bak_info.txt 2>&1

# 增量备份合并到全量备份
#innobackupex --apply-log  --redo-only 全量路径
# --redo-only只应用redo日志,不执行undo回滚未提交的数据，等最后一次增量备份合并完成后再进行应用undo日志回滚数据。
/opt/xtrabackup/bin/innobackupex --apply-log  --redo-only $back_dir/$all_back_dir
# innobackupex --apply-log  --incremental-dir=增量路径 全量路径
/opt/xtrabackup/bin/innobackupex --apply-log --incremental-dir=$increment_back_dir/$last_increment_back_dir $back_dir/$all_back_dir


