#!/bin/bash
#
#program:
#    自定义rm
#
#history:
#2020/03/18    kun    V1.0

filename=$1
big_filesystem=/data

if [ ! -e $1 ]
then
    echo "$1 不存在，请使用绝对路径"
    exit
fi

d=`date +%Y%m%d%H%M`
read -p "Are you sure delete the file or directory $1 ? y|n " c
case $c in
    Y|y)
        mkdir -p $big_filesystem/.$d && rsync -R $filename $big_filesystem/.$d/$filename && rm -rf $filename
        ;;
    N|n)
        exit 0
        ;;
    *)
        echo "Please input 'y' or 'n'."
        ;;
esac
