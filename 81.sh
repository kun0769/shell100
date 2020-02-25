#!/bin/bash
#
#program:
#    每5s检测一次磁盘io ，当发现问题去查询mysql的进程列表。
#
#history:
#2020/02/25    kun    V1.0

if ! which iostat &>/dev/null
then
    yum install -y sysstat
fi

while :
do
    iostat -dx 1 5 |grep sda > 81_io.log
    #awk中把NF端的值给全部统计起来
    sum=`cat 81_io.log|awk '{sum=sum+$NF} END {print sum}'`
    #当bc结果是.开头 可以使用awk格式化输出为0.
    avg=`echo "scale=2;$sum/5" |bc |awk '{printf "%.2f",$0}'`
    #取整数部分
    avg_z=`echo $avg |cut -d. -f 1`
    if [ $avg_z -gt 90 ]
    then
        mysql -uroot -proot1234 -e "show processlist" > 81_mysql_processlist.log
    fi
done
