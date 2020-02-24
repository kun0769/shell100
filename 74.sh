#!/bin/bash
#
#program:
#    删除文件中的注释部分内容
#    获取文件中所有artifactItem的内容
#    并用如下格式逐行输出： artifactItem:groupId:artifactId:aaa
#
#history:
#2020/02/24    kun    V1.0

#删除注释在同一行的情况
sed '/<!--.*-->/d' test.xml > test2.xml
#记录注释不在同一行情况每行的行号
egrep -n '<!--|-->' test.xml |awk -F ':' '{print $1}' > 74_line_number1.txt
#统计总行数来获得有多少组注释
n=`wc -l 74_line_number1.txt |awk '{print $1}'`
n1=$[$n/2]

#遍历记录行号的文件每组再删除不同行的注释
for group in `seq 1 $n1`
do
    #获得每组的单双行和对应的内容，即是行号
    j=$[$group*2] #双
    k=$[$j-1] #单 k=$[$group*2-1]
    x=`sed -n "$k"p 74_line_number1.txt`
    y=`sed -n "$j"p 74_line_number1.txt`
    sed -i "$x,$y"d test2.xml
done

#记录有artifactItem>行的行号和统计总行数和组数
grep -n 'artifactItem>' test2.xml |awk -F ':' '{print $1}' > 74_line_number2.txt
n2=`wc -l 74_line_number2.txt |awk '{print $1}'`
n3=$[$n2/2]

#格式化输出groupId和artifactId的行的函数
get_value()
{
    sed -n "$1,$2"p test2.xml|awk -F '<' '{print $2}'|awk -F '>' '{print $1,$2}' > 74_value.txt
    cat 74_value.txt |while read line
    do
        x=`echo $line |awk '{print $1}'`
        y=`echo $line |awk '{print $2}'`
        echo "artifactItem:$x:$y"
    done
}

for group in `seq 1 $n3`
do
    j=$[$group*2] #双
    k=$[$j-1] #单
    num1=`sed -n "$k"p 74_line_number2.txt`
    num2=`sed -n "$j"p 74_line_number2.txt`
    num3=$[$num1+1] #获得groupId的行号
    num4=$[$num2-1] #获得artifactId的行号
    get_value $num3 $num4
done
