#!/bin/bash
######### 此脚步需要在完整备份脚本之前运行

src_dir=/data2/mysql_binlogs/
dest_dir=/data2/mysql_bak/binlog

mkdir -p /data2/mysql_bak/binlog/{change,source} >/dev/null 2>&1

# 上次完整备份A，时间20150102
# 本次完整备份B，时间20150103
# change 目录中，20150102 之后的所有mysql日志文件 C
# A + C + mysql运行目录中的日志 = 实时的mysql完整备份
# B + mysql运行目录中的日志 = 实时的mysql完整备份
# 所以，建议不删除老的日志文件
/usr/bin/rsync -abvcz --progress --delete --backup-dir=${dest_dir}/change/`date +%Y%m%d` --exclude=mysql-relay-bin.* ${src_dir} ${dest_dir}/source/
