#!/bin/bash
#
#program:
#    写一个脚本查找/ data / log目录下，创建时间是3天前，后缀是* .log的文件，打包后发送至192.168.1.2服务上的/ data / log下，并删除原始.log文件，仅保留打包后的文件。
#
#history:
#2020/02/25    kun    V1.0

day=`date +%F`

cd /data/log
find ./ -mtime +3 -type f -name "*.log" > 76_file.log
tar zcf $day.tar.gz `cat 76_file.log|xargs`
rsync -a $day.tar.gz 192.168.1.2:/data/log
cat 76_file.log|xargs rm
