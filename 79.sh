#!/bin/bash
#
#program:
#    两类机器一共300多台，写个脚本自动清理这两类机器里面的日志文件。在堡垒机批量发布，也要批量发布到crontab里面。
#    A类机器日志存放路径很统一，B类机器日志存放路径需要用匹配（因为这个目录里除了日志外，还有其他文件，不能删除。匹配的时候可用.log）
#    A类：/opt/cloud/log/ 删除7天前的
#    B类: /opt/cloud/instances/ 删除15天前的
#    要求写在一个脚本里面。不用考虑堡垒机上的操作，只需要写出shell脚本。
#
#history:
#2020/02/25    kun    V1.0

a=/opt/cloud/log/
b=/opt/cloud/instances/

if [ -d $a ]
then
    find $a -mtime +7 -type f |xargs rm -rf 
elif [ -d $b ]
then
    find $b -name "*.log" -type f -mtime +15 |xargs rm -rf 
fi
