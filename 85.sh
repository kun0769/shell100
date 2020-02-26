#!/bin/bash
#
#program:
#    查看1s的内的日志数量统计网站的并发量
#
#history:
#2020/02/26    kun    V1.0

log=/data/logs/www.aaa.com_access.log
LANG=en
#1s前的时间
time=`date -d "-1 second" +%d/%b/%Y:%T`
#由于日志大,导致grep速速满 因此估计3000条日志
tail -3000 $log |grep -c "$time" 
