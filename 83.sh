#!/bin/bash
#
#program:
#    用户输入多个城市的名字（可以是中文），要求不少于5个，然后把这些城市存到一个数组里，最后用for循环把它们打印出来。
#
#history:
#2020/02/26    kun    V1.0

read -p "请输入至少5个城市名字,用空格分开: " name
#NF表示总段数 $NF表示最后段的值
n=`echo $name |awk '{print NF}'`

if [ $n -lt 5 ]
then
    echo "输入的城市个数至少为5."
    exit
fi

#数组赋值
city=($name)
#显示数组city所有内容
#echo ${city[@]}

for i in `seq 0 $[${#city[@]}-1]`
do
    echo ${city[$i]}
done
