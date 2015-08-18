#! /bin/bash
log_dir=/var/log/rsync

run_log=${log_dir}/run.log

#传输日志
db_binlog_tr_log=${log_dir}/db_binlog_tr.log
db_dump_tr_log=${log_dir}/db_dump_tr.log
nfs_tr_log=${log_dir}/nfs_tr.log
web_tr_log=${log_dir}/web_tr.log

time=`date +%F%t%T`

prefix="rsync -abvcz --progress --delete --backup-dir="

mkdir -p ${log_dir} 2>&1 >/dev/null
mkdir -p /data2/backup/db/binlog/{change,source} /data2/backup/db/dump/{change,source} 2>&1 >/dev/null
mkdir -p /data2/backup/nfs/{change,source} 2>&1 >/dev/null
mkdir -p /data2/backup/web/{change,source} 2>&1 >/dev/null

echo >> ${run_log}
echo "Start: ${time}" >>${run_log}

cmd=${prefix}"/data2/backup/db/binlog/change/`date +%Y%m%d` --log-file=${db_binlog_tr_log} 10.10.10.102::db_binlog_bak /data2/backup/db/binlog/source/"
echo ${time} $cmd >>${run_log}
$cmd

cmd=${prefix}"/data2/backup/db/dump/change/`date +%Y%m%d` --log-file=${db_dump_tr_log} 10.10.10.102::db_dump_bak /data2/backup/db/dump/source/"
echo ${time} $cmd >>${run_log}
$cmd

cmd=${prefix}"/data2/backup/nfs/change/`date +%Y%m%d` --log-file=${nfs_tr_log} 12.12.12.90::nfs_bak /data2/backup/nfs/source/"
echo ${time} $cmd >>${run_log}
$cmd

cmd=${prefix}"/data2/backup/web/change/`date +%Y%m%d` --log-file=${web_tr_log} 10.10.10.202::web_bak /data2/backup/web/source/"
echo ${time} $cmd >>${run_log}
$cmd

echo "Finish: `date +%F%t%T`" >>${run_log}

echo >> ${run_log}
echo >> ${run_log}
echo >> ${run_log}
echo >> ${run_log}
