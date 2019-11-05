#!/bin/bash
#
#program:
#    检测web服务
#
#history:
#2019/09/22    kun    V1.0

n=$(netstat -lntp |grep ":22 "|wc -l)

if [ $n == 0 ];then
    echo "没有web服务在监听..."
else
    n1=$(netstat -lntp |grep ":22 " |awk -F'/' '{print $NF}'|sort|uniq|sed 's/ //g')
    echo "现在监听的服务是$n1."
fi
