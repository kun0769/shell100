#!/bin/bash
#
#program:
#    需求是，把所有的成员平均分成几个个小组。这里，提供一个人员列表，某些成员有50人，需要分成7个小组，要求随机性，每次和每次分组的结果应该分开。
#
#history:
#2020/02/11    kun    V1.0

#人员列表文件
f=59_member.txt
#小组数
group_n=7
#人员总数
member_n=`wc -l $f |awk '{print $1}'`

#根据姓名计算该用户所在小组的id
get_n()
{
    #根据姓名计算cksum值
    l=`echo $1 |cksum |awk '{print $1}'`
    #获取一个随机数
    n1=$RANDOM
    #cksum值和随机数相加，除以小组数取余，这样可以确保每次获得的余数不一样
    n2=$[$l+$n1]
    g_id=$[$n2%$group_n]
    #小组数为7，则余数范围0-6(余数一定小于除数)，余数是0，则小组为7
    if [ $g_id -eq 0 ]
    then
        g_id=$group_n
    fi
    echo $g_id
}

for i in `seq 1 $group_n`
do
    #n_$i.txt为临时文件，用来记录该小组内的成员
    #脚本之前执行过，则该文件会存在，本次执行前应该先删除之前的临时文件
    [ -f n_$i.txt ] && rm -rf n_$i.txt
done

shuf $f|while read name
do
    #计算用户所在小组的id
    g=`get_n $name`
    #将人员写到他对应的小组临时文件中
    echo $name >> n_$g.txt
done

#定义计算文件行数的函数
nu()
{
    wc -l $1 |awk '{print $1}'
}

#获取成员人数最多的小组
max()
{
    ma=0
    for i in `seq 1 $group_n |shuf`
    do
        n=`nu n_$i.txt`
        if [ $n -gt $ma ]
        then
            ma=$n
        fi
    done
    echo $ma
}

#获取成员人数最少的小组
min()
{
    mi=$member_n
    for i in `seq 1 $group_n |shuf`
    do
        n=`nu n_$i.txt`
        if [ $n -lt $mi ]
        then
            mi=$n
        fi
    done
    echo $mi
}

#定义四舍五入函数
div()
{
    n=`echo "scale=1;$1/$2" |bc`
    n1=`echo "scale=1;$n+0.5" |bc`
    echo $n1 |cut -d. -f1
}

#小组成员平均数（非四舍五入）
ava_n=$[$member_n/$group_n]
#小组成员平均数（四舍五入）
ava_n1=`div $member_n $group_n`

if [ $ava_n -eq $ava_n1 ]
then
    #定义初始最小值
    ini_min=1
    #以下while循环要做的事情是把人数多的组的人搞到人数少的组里去
    #此while循环的条件是，当人数最少的组成员数小于组员平均值
    while [ $ini_min -lt $ava_n1 ]
    do
        #找出人数最多的组
        m1=`max`
        #找出人数最少的组
        m2=`min`
        for i in `seq 1 $group_n |shuf`
        do
            n=`nu n_$i.txt`
            #找到人数最多的组对应的文件f1（可能有多个，这里取出现的第一个即可）
            if [ $n -eq $m1 ]
            then
                f1=n_$i.txt
            #找到人数最少的组对应的文件f2（可能有多个，这里取出现的第一个即可）
            elif [ $n -eq $m2 ]
            then
                f2=n_$i.txt
            fi
        done
        #取f1中最后一个人名
        name=`tail -n1 $f1`
        #将这个人名追加写入f2中
        echo $name >> $f2
        #在f1中删除刚刚取走的人名
        sed -i "/$name/d" $f1
        #把此时的最少组人员数赋值给ini_min
        ini_min=`min`
    done
else
    #定义初始最大值
    ini_max=$member_n
    #以下while循环要做的事情是把人数多的组的人搞到人数少的组里去
    #此while循环的条件是，当人数最多的组成员数大于组员平均值
    while [ $ini_max -gt $ava_n1 ]
    do
        #找出人数最多的组
        m1=`max`
        #找出人数最少的组
        m2=`min`
        for i in `seq 1 $group_n |shuf`
        do
            n=`nu n_$i.txt`
            #找到人数最多的组对应的文件f1（可能有多个，这里取出现的第一个即可）
            if [ $n -eq $m1 ]
            then
                f1=n_$i.txt
            #找到人数最少的组对应的文件f2（可能有多个，这里取出现的第一个即可）
            elif [ $n -eq $m2 ]
            then
                f2=n_$i.txt
            fi
        done
        #取f1中最后一个人名
        name=`tail -n1 $f1`
        #将这个人名追加写入f2中
        echo $name >> $f2
        #在f1中删除刚刚取走的人名
        sed -i "/$name/d" $f1
        #把此时的最少组人员数赋值给ini_max
        ini_max=`max`
    done
fi

for i in `seq 1 $group_n `
do
    echo -e "\033[34m$i 组成员有：\033[0m"
    cat n_$i.txt
    #删除临时文件
    rm -rf n_$i.txt
    echo 
done

