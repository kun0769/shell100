#!/bin/bash
#
#program:
#    给出一个进程PID，打印出该进程下面的子进程以及子进程下面的所有子进程
#
#history:
#2020/02/13    kun    V1.0

read -p "请输入一个PID: " pid
[ -z "$pid" ] && echo "不能为空，请重新输入" && exit

ps -elf > 68_pid.tmp
if ! grep -wq "$pid" 68_pid.tmp
then
    echo "你输入的PID并不存在，请重输入" && exit
fi

#获得该进程的子进程函数
get_cpid()
{
    p1=$1
    ps -elf|awk -v j=$p1 '$5==j {print $4}' > 68_$p1.tmp
    n=`wc -l 68_$p1.tmp |awk '{print $1}'`
    if [ $n -eq 0 ]
    then
        echo "PID $p1 进程下并没有进程"
    else
        echo "PID $p1 进程的子进程如下:"
        cat 68_$p1.tmp
    fi
}

get_cpid $pid

for i in `cat 68_$pid.tmp`
do
    get_cpid $i
done

rm -rf 68_*.tmp
