#!/bin/bash
#
#program:
#    提示输入一个暂停的数字，然后从1打印到该数字。然后询问是否继续。继续的话再输入一个数字接着打印，否则退出脚本。
#    例：如果输入的是5，打印1 2 3 4 5，然后继续输入15，然后打印6 7 …14 15 以此类推。
#
#history:
#2020/02/10    kun    V1.0

judge(){
    num=`echo $1 |sed 's/[0-9]//g'`
    [ -n "$num" ] && echo "Please input a number." && exit
}

read -p "Please input a number: " n
judge $n

for i in `seq 1 $n`
do
    echo $i
done

read -p "If continue? y/n: " c
case $c in
    y|Y)
        read -p "Please input a number: " n1
        judge $n1
        if [ $n1 -le $n ]
        then
	    echo "Please input a number grater then $n." && exit
	else
	    for i in `seq $[$n+1] $n1`
	    do
	        echo $i
	    done
        fi
        ;;
    n|N)
        exit
        ;;
    *)
        echo "Please input y or n." && exit
        ;;
esac
