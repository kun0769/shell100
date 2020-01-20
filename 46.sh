#!/bin/bash
#
#program:
#    getinterface.sh [-i interface | -I ip]
#    当用户使用-i选项时，显示指定网卡的IP地址；当用户使用-I选项时，显示其指定ip所属的网卡
#
#history:
#2020/01/18    kun    V1.0

#把所有网卡写入临时文件
ip add |awk -F ': ' '$1 ~/^[0-9]/ {print $2}' > /tmp/46_int.log

#获得网卡对应IP地址
get_ip(){
    ip add |grep -w $1|grep 'inet'|awk -F '/' '{print $1}'|awk '{print $2}'
}

#把网卡和IP地址对应关系写入到临时文件中
for int in `cat /tmp/46_int.log`;do
    myip=`get_ip $int`
    myip_wc=`echo -e $myip |wc -l`
    if [ $myip_wc -gt 1 ];then
        for i in `echo $myip`;do
            echo "$int $myip"
        done
    else
	echo $int $myip
    fi
done > /tmp/46_int_ip.log

if [ $# -ne 2 ];then
    echo "Usage: sh $0 [ -i|I ] <interface|IP>"
    exit
fi

if [ $1 == "-i" ];then
    if `cat /tmp/46_int_ip.log |grep $2 >/dev/null 2>&1`;then
        echo "网卡$2对应IP地址是`cat /tmp/46_int_ip.log |grep $2|awk '{print $2}'|xargs`"
    else
	echo "你指定的网卡不对，系统网卡有`cat /tmp/46_int.log|xargs`"
	exit
    fi
elif [ $1 == "-I" ];then
    if `cat /tmp/46_int_ip.log |grep $2 >/dev/null 2>&1`;then
	echo "IP地址$2对应的网卡是`cat /tmp/46_int_ip.log|grep $2|awk '{print $1}'|sort|uniq`"
    else
	echo "你指定的IP地址不对，系统IP地址有`cat /tmp/46_int_ip.log|awk '{print $2}'|sort|uniq|xargs`"
	exit
    fi
else
    echo "Usage: sh $0 [ -i|I ] <interface|IP>"
fi
