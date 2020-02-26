#!/bin/bash
#
#program:
#    写一个shell脚本，用chkconfig工具把不常用的服务关闭。脚本需要写成交互式的，需要我们给它提供关闭的服务名字。
#
#history:
#2020/02/26    kun    V1.0

LANG=en

while :
do
    #chkconfig --list 2>/dev/null 可以把chkconfig 帮助信息过滤掉
    chkconfig --list 2>/dev/null |grep "3:on"|awk '{print $1}' > 86_on_server.txt
    echo -e "\033[34m系统中已经启动的服务有: \033[0m "
    for i in `cat 86_on_server.txt`
    do
        echo -e "\033[32m$i\033[0m"
    done

    read -p "请选择要关闭的服务: " service
    if ! grep -qw "$service" 86_on_server.txt
    then
        echo -e "\033[31m该输入不在服务列表中.\033[0m" && continue
    else
        chkconfig $service off
        echo -e "\033[32m$service\033[0m服务停止成功."
        break
    fi
done
