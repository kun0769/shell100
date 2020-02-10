#!/bin/bash
#
#program:
#    统计下早上10点到12点来访ip最多的日志
#
#histroy:
#2020/02/10    kun    V1.0

export LANG=en
log="/usr/local/nginx/logs/access.log"
date=`date +%d/%b/%Y:1[01]:[0-5][0-9]:`

egrep "$date" $log |awk '{print $1}' |sort -n |uniq -c |sort -n |tail -1 |awk '{print $2}'
