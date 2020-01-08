#!/bin/bash
#
#program:
#    输出一个随机的0-99之间的数字,输入相同的名字，输出的数字还是第一次输入该名字时输出的结果
#    前面已经输出过的数字，下次不能再出现,当输入q或者Q时，脚本会退出。
#
#history:
#2020/01/08    kun    V1.0

judge(){
while :
do
    num=$[$RANDOM%100]
    if grep -w "$name" $filetarget >/dev/null 2>&1;then
	grep_name=`grep -w "$name" $filetarget|awk '{print $1}'`
	grep_num=`grep -w "$name" $filetarget|awk '{print $2}'`
	echo "用户$grep_name获得数字->$grep_num"
        break
    fi
    if awk '{print $2}' $filetarget|grep $num >/dev/null 2>&1;then
        continue
    else
        echo "用户$name获得数字->$num"
        echo "$name $num" >> $filetarget
        break
    fi
done
}

filetarget=/tmp/shell_35.log

while :
do
    read -p "请输入名字(q/Q退出脚本):" name
    if [ "$name" == "q" ] || [ "$name" == "Q" ];then
        echo "退出脚本..." && exit 0
    fi
    name_1=`echo $name|sed s/[a-zA-A0-9]//g`
    if [ -n "$name_1" ];then
        echo "输入名字必须是英文，可以是大小写字母，数字不能有其他特殊符号!"
        continue
    fi
    if [ -f $filetarget ];then
	judge
    else
        > $filetarget
	judge
    fi
done
