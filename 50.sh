#!/bin/bash
#
#program:
#    监控网卡的脚本
#    1. 每10分钟检测一次指定网卡的流量。
#    2. 如果流量为0，则重启网卡。
#
#history:
#2020/02/09    kun    V1.0

LANG=en
sar -n DEV 1 10 |grep -w "$1" >/tmp/50.tmp

#获得sar文件中 rxkB/s和txkB/s的值
in=`grep "Average:" /tmp/50.tmp |awk '{print $5}' |sed 's/\.//'`
out=`grep "Average:" /tmp/50.tmp |awk '{print $6}' |sed 's/\.//'`

#rxkB/s和txkB/s的值都是0时候重启网卡
if [ $in == "000" ] && [$out == "000" ];then
    ifdown $1 && ifup $1
fi
