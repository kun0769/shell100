#!/bin/bash
#
#program:
#    实现简单的弹出式菜单功能
#
#history:
#2020/01/12    kun    V1.0

PS3="请选择数字1-4:"

select cmd in w ls pwd quit;do
    case $cmd in
	w)
	    w
	    ;;
	ls)
	    ls
	    ;;
	pwd)
	    pwd
	    ;;
	quit)
	    exit
	    ;;
	*)
	    echo "请输入数字1-4"
    esac
done
