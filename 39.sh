#!/bin/bash
#
#program:
#    写一个shell脚本，检查指定的shell脚本是否有语法错误。有错误，显示错误信息，然后提示用户输入q或者Q退出脚本，输入其他内容则直接用vim打开该脚本
#
#history:
#2020/01/11    kun    V1.0

sh -n $1 2>/tmp/39.err
if [ $? -eq 0 ];then
    echo "脚本$1没有语法错误..."
else
    cat /tmp/39.err
    read -p "请输入q/Q退出脚本:" cmd
    [ -z "$cmd" ] && /usr/bin/vim $1 && exit 0
    if [ $cmd == "q" ] || [ $cmd == "Q" ];then
	exit 0
    else
	/usr/bin/vim $1
	exit 0
    fi
fi
