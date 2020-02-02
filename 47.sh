#!/bin/bash
#
#program:
#    产生随机3位的数字，并且可以根据用户的输入参数来判断输出几组
#
#history:
#2020/02/02    kun    V1.0

get_number(){
    for i in `seq 0 2`;do
	#数组下标0-2分别接受三个随机数字
        a[$i]=$[$RANDOM%10]
    done
    #去掉数组中间的空格
    echo ${a[@]}|sed 's/ //g'
}

if [ $# -eq 0 ];then
    get_number
elif [ $# -eq 1 ];then
    n=`echo $1|sed 's/[0-9]//g'`
    if [ -n "$n" ];then
        echo "给的参数必须是个数字..."
	exit
    fi
    for i in `seq 1 $1`;do
        get_number
    done|xargs
else
    echo "格式错误，正确格式是sh $0 [n]，n为产生n组三位随机数..."
fi
