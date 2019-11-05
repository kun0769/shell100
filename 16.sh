#!/bin/bash
#
#program:
#    统计系统的自定义用户的个数
#
#history:
#2019/09/17    kun    V1.0

n=$(awk -F 'release ' '{print $2}' /etc/redhat-release |cut -d'.' -f1)
user()
{
    if [ $1 -eq 0 ];then
        echo "系统存在自定义用户，共$1"
    else
        echo "系统没有自定义用户"
    fi
}

case $n in
    5|6)
        d=$(awk -F':' '$3>1000' /etc/passwd| wc -l)
        user $d
    ;;
    7)
        d=$(awk -F':' '$3>1000' /etc/passwd| wc -l)
        user $d
    ;;
    *)
        echo "脚本出错..."
    ;;
esac
