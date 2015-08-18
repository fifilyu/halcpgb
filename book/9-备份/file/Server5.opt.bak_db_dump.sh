#!/bin/bash

current_date=`date +%Y_%m_%d`

bak_home_dir=/data2/mysql_bak/dump
lock_file=${bak_home_dir}/db.lock
bak_log=${bak_home_dir}/full_db_bak.log

bak_file_name=all_mysql_dump_${current_date}.sql
bak_file_path=${bak_home_dir}/${bak_file_name}

bak_file_tar=${bak_file_path}.tar.gz

mkdir -p ${bak_home_dir} 2>&1 >/dev/null

echo -n `date "+%Y-%m-%d %T"` >> ${bak_log}

if [ -f ${lock_file} ]; then
    echo " The ${lock_file} exists." >> ${bak_log}
    exit 1
fi

echo -n " Dump all mysql database... " >> ${bak_log}

# 1. --single-transaction 锁定数据库
# 2. --flush-logs 重新打开并写入日志到此新文件 mysql-bin.000010
# 3. --delete-master-logs 删除  mysql-bin.000010 之前的所有日志
# 4. --master-data 保留执行 mysqldump 的服务器上 mysql 的日志 file 和 position 信息
# 通过 $head -n 50 all_mysql_dump_2150113.sql|grep 'CHANGE MASTER TO' 查看：
#  CHANGE MASTER TO MASTER_LOG_FILE='mysql-bin.000011', MASTER_LOG_POS=106;
# 
# 最后完整mysqldump的sql文件 +  mysql-bin.000010以及之后的所有日志文件 = 完整备份 + 增量
# 每周做一次完整备份，每天做一次日志备份。

# mysql日志文件有两份，一份在mysql bin log目录，一份复制到备份目录，作为此为增量备份。
# 如果日志太多，无法确定哪个是完整备份后产生的日志文件，请参考
# CHANGE MASTER TO MASTER_LOG_FILE='mysql-bin.000011', MASTER_LOG_POS=106;
/usr/bin/mysqldump -uroot -p'rootpassword' --all-databases --add-drop-database --add-drop-table --single-transaction --flush-logs --delete-master-logs --events --master-data > ${bak_file_path}

tar zcf ${bak_file_tar} -C ${bak_home_dir} ${bak_file_name} 2>${bak_log}.err
rm -f ${bak_file_path} ${lock_file}

echo " done." >> ${bak_log}
