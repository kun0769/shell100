#!/bin/bash
#
#program:
#    编写一个问候程序，他执行时能够根据系统当前的时间想用户输出问候信息。
#    假设半夜到中午为早晨，中午到下午6点为下午，下午6点到半夜为晚上。
#
#history:
#2020/01/12    kun    V1.0

hour=`date +%H`
user=`whoami`

if [ $hour -ge 0 -a $hour -lt 7 ];then
    tag=1
elif [ $hour -ge 7 -a $hour -lt 12 ];then
    tag=2
elif [ $hour -ge 12 -a $hour -lt 18 ];then
    tag=3
else
    tag=4
fi

case $tag in
    1)
	echo "凌晨好,$user 请注意休息"
	;;
    2)
	echo "早上好,$user 请享受今天"
	;;
    3)
	echo "下午好,$user 下午茶时间到了"
	;;
    4)
	echo "晚上好,$user 总结下今天的事情吧"
	;;
    *)
	echo "脚本出错"
	;;
esac
