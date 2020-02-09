#!/bin/bash
#
#program:
#    监控iptables规则是否正确封掉了22端口，如果封掉了，给打开。
#
#history:
#2020/02/09    kun    V1.0

iptables -nvL INPUT --line-number |grep -w 'dpt:22' |awk '$4 ~/DROP|REJECT/ {print $1}' > /tmp/53.log

n=`cat /tmp/53.log |wc -l`
if [ $n -ne 0 ]
then
    #顺序删除规则,后面的规则序号会自动更改为上一个序号
    #因此使用tac命令来倒序读取文件
    for i in `tac /tmp/53.log`
    do
        iptables -D INPUT $i
    done
fi
