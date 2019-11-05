#!/bin/bash
#
#program:
#    两个参数之间进行加减乘除
#
#history:
#2019/09/22    kun    V1.0


#判断是数字
file_num(){
    n=$(echo $1 |sed 's/[0-9]//g')
    [ -n "$n" ] && echo "$1不是数字,请输入数字..." && exit
}


if [ $# -eq 2 ];then
    file_num $1
    file_num $2
else
    echo "请输入两个参数..." 
    exit
fi

max(){
    [ $1 -ge $2 ] && echo $1 || echo $2
}

min(){
    [ $1 -lt $2 ] && echo $1 || echo $2
}

sum(){
    sum=$[$1+$2]
    echo "$1+$2=$sum"
}

minus(){
    big=`max $1 $2`
    small=`min $1 $2` 
    minus=$[$big-$small]
    echo "$big-$small=$minus"
}

mult(){
    mult=$[$1*$2]
    echo "$1x$2=$mult"
}

div(){
    big=`max $1 $2`   
    small=`min $1 $2` 
    div=`echo "scale=2;$big/$small"|bc`
    echo "$big/$small=$div"
}

sum $1 $2
minus $1 $2
mult $1 $2
div $1 $2
