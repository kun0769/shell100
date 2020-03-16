#!/bin/bash
#
#program:
#    只要把盘符和挂载点以参数的形式提供给脚本，该脚本就可以自动格式化、挂载
#
#history:
#2020/03/16    kun    V1.0

if [ $# -ne 2 ]
then
    echo "Useage $0 盘符 挂载点, 如： $0 /dev/xvdb /data"
    exit 1
fi

#-b检测是否为设备
if [ ! -b $1 ]
then
    echo "你提供的盘符不正确，请检查后再操作"
    exit 1
fi

echo "格式化$1"
mkfs -t ext4 $1

if [ ! -d $2 ]
then
    mkdir -p $2
fi

if ! grep -wq "$2" /ect/fstab
then
    echo "$1              $2                      ext4   defaults  0  0" >> /etc/fstab
    mount -a
else
    echo "配置文件/etc/fstab中已经存在挂载点$2,请检查一下."
    exit 1
fi
