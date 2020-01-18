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
