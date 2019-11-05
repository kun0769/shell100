#!/bin/bash
#
#program:
#    检测记录磁盘分区使用率和inode使用率
#
#history:
#2019/09/17    kun    V1.0


log=/tmp/disk/$(date +%F).log
tag1=0
tag2=0

exprot export LC_ALL=C
[ ! -d /tmp/disk ] && mkdir -p /tmp/disk
date +%F:%T >> $log
df >> $log
df -i >> $log

for i in $(df |sed '1d'|awk '{print $5}' |sed -r 's/(\.(.*)%$|%$)//')
do
    if [ $i -gt 85 ];then
        tag1=1
    fi
done

for i in $(df -i|sed '1d'|awk '{print $5}' |sed -r 's/(\.(.*)%$|%$)//')
do
    if [ $i -gt 85 ];then
        tag2=1
    fi
done

if [ $tag1 -eq 0 ]
then
    if [ $tag2 -eq 0 ];then
        tag=0
    else
        tag=2
    fi
fi
if [ $tag -eq 1 ]
then
    if [ $tag2 -eq 1 ];then
        tag=3
    else
        tag=1
    fi
fi

case $tag in
    1)
    python mail.py "磁盘空间大于85%..." "$(df)"
    ;;
    2)
    python mail.py "inode使用率大于85%..." "$(df -i)"
    ;;
    3)
    python mail.py "磁盘空间和inode使用率都大于85%..." "$(df;df -i)"
    ;;
    0)
    echo "没事。。。"
    ;;
esac
