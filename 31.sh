#!/bin/bash
#
#program:
#    获取网卡ip地址
#
#history:
#2019/09/30    kun    V1.0

get_ip(){
    address=`ip address show|grep -w "$1"|grep "inet "|awk '{print $2}'`
    #echo -e "\033[32m$address\033[0m"
    echo -e "\033[5;32m$address\033[0m"
}

ip address show|egrep "^[0-9]+"|awk -F': ' '{print $2}'|xargs > /tmp/ent.list

while :
do
    list=`cat /tmp/ent.list`
    read -p "请输入以下任意一个接口(`echo -e "\033[36m$list\033[0m"`):" ip
    [ -z $ip ] && echo "不能为空..." && continue
    if ! grep -qw "$ip" /tmp/ent.list 
    then
        echo "输入的接口不正确..."
        continue
    fi
    break
done

get_ip $ip
