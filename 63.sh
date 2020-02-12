#!/bin/bash
#
#program:
#    以并发进程的形式将mysql数据库所有的表备份到当前目录，并把所有的表压缩到一个压缩包文件里。
#    假设数据库名字为mydb，用户名为aming，密码为passwd。
#
#history:
#2020/02/12    kun    V1.0

#设置并发数
N=5
#获得mydb总表数的临时文件
mysql -uaming -ppasswd mydb -e "show tables"|sed "1d" > /tmp/63.log
#总表数量
n=`wc -l /tmp/63.log |awk '{print $1}'`

#四舍五入
div()
{
    n=`echo "scale=1;$1/$2" |bc`
    n1=`echo "scale=1;$n+0.5" |bc`
    echo $n1 |cut -d. -f1
}

#切割后的每个文件的行数
line=`div $n $N`

#获得切割后的临时文件xaa xab xac xad xae
split -l $line /tmp/63.log

#对临时文件每个表进行备份
myd()
{
    for table in `cat $1`
    do
        myslqdump -umysql -ppasswd mydb $table > $table.sql
    done
}

for file in xaa xab xac xad xae
do
    #放到后台执行实现并行执行
    myd $file &
done

#等待后台进程完成再打包
wait && tar zcf mydb.tar.gz *.sql
rm -rf *.sql
