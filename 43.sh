#!/bin/bash
#
#program:
#    检测指定的用户是否登录系统
#
#history:
#2020/01/12    kun    V1.0

while :
do
    if w|sed '1,2d'|awk '{print $1}'|grep -qw "$1";then
	echo "用户$1已经登录系统..."
    else
	echo "用户$1不在系统..."
    fi
    sleep 300
done
