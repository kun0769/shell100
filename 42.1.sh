#!/bin/bash
#
#program:
#    实现简单的弹出式菜单功能
#
#history:
#2020/01/12    kun    V1.0

echo -e "1) w\n2) ls\n3) pwd\n4) quit"
while :
do
    read -p "请选择数字1-4:" cmd
    case $cmd in
	1)
	    w
	    ;;
	2)
	    ls
	    ;;
	3)
	    pwd
	    ;;
	4)
	    exit
	    ;;
	*)
	    echo "请输入数字1-4"
	    ;;
    esac
done
