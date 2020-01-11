#!/bin/bash
#
#program:
#    写一个shell脚本，把192.168.0.0/24网段在线的IP列出来。
#
#history:
#2020/01/11    kun    V1.0

ip="192.168.0."

for i in `seq 1 254`;do
    if ping -c 1 -w 1 $ip$i >/dev/null 2>&1;then
	echo "$ip$i 是通的."
    else
	echo "$ip$i 不通."
    fi
done
