#!/bin/bash
#
#program:
#    检查进程得pid是否在/proc中，并不包含本脚本的进程号和子进程号
#
#history:
#2020/01/13    kun    V1.0

#本脚本的pid
ppid=$$
echo $ppid

ps -elf |sed '1d' > /tmp/44.log
#j变量在awk等于$$ $4表示进程号 $5表示父进程号 如果改进程号的ppid是本机的pid就会给过滤掉
for pid in `awk -v j=$ppid '$5!=j {print $4}' /tmp/44.log`;do
    if [ ! -d /proc/$pid ];then
	echo "系统中并没有pid为$pid的目录，请检查系统..."
    fi
done
