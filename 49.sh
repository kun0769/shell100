#!/bin/bash
#
#program:
#    用shell脚本判断输入的日期是否合法。
#    例如20170110就是合法日期，20171332就不合法。
#
#history:
#2020/02/09    kun    V1.0


#判断参数数量为1和参数值为8位数
if [ $# -ne 1 ] || [ ${#1} -ne 8 ];then
    echo "输入日期格式不对,sh $0 yyyymmdd"
    exit 1
fi

#获得参数1的年月日
y=`echo ${1:0:4}`
m=`echo ${1:4:2}`
#cal中日期1-9不带0,因此开头是0的数字要去0 
d=`echo ${1:0-2:2}|sed s/^0//`

if cal $m $y >/dev/null 2>&1;then
    if cal $m $y |grep -w "$d" >/dev/null 2>&1;then
        echo "日期合法"
    else
        echo "你输入的日期不合法,请根据下面日历输入00-31"
	cal $m $y
    fi
else
    echo "月份输入错误,请输入0-12"
fi
