#!/bin/bash
#
#program:
#    监控各个节点是否正常
#
#history:
#2020/02/12    kun    V1.0

url=www.aming.com/index.php
s_ip=88.88.88.88
#所有节点IP文件
ip_file=/tmp/ip.list

#2>/dev/null用于把curl命令中下载过程过滤掉
curl -x$s_ip $url 2>/dev/null >/tmp/source.txt

for ip in `cat $ip_file`
do
    curl -x$ip $url 2>/dev/null >/tmp/$ip.txt
    diff /tmp/source.txt /tmp/$ip.txt >/tmp/$ip.diff
    n=`wc -l /tmp/$ip.diff |awk '{print $1}'`
    if [ $n -ne 0 ]
    then
        echo "节点$ip有异常"
    fi
done
