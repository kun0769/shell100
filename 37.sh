#!/bin/bash
#
#program:
#    日志切割脚本
#    假如服务的输出日志是1.log，要求每天归档一个，1.log第二天就变成1.log.1，第三天1.log.2, 第四天 1.log.3  一直到1.log.5
#
#history:
#2020/01/10    kun    V1.0

logfile=/home/kun/test/1.log

cd /tmp
[ -f $logfile.5 ] && rm -rf $logfile.5
for i in `seq 4 -1 1`;do
    j=$[$i+1]
    [ -f $logfile.$i ] && mv $logfile.$i $logfile.$j
done
mv $logfile $logfile.1
