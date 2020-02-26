#!/bin/bash    
#    
#program:    
#    这个脚本可以取tomcat实例t1-t4的日志
#    这个脚本可以自定义取日志的起始点 ，比如取今天早上10点之后到现在的数据
#    这个脚本可以自定义取日志的起始点和终点，比如取今天早上9点到晚上8点的数据 catalina.out 日志内容
#    sh 82.sh t1 08:01:00 14:00:00 
#    
#history:    
#2020/02/26    kun    V1.0  

LANG=en
logfile="/opt/TOM/$1/logs/catalina.out"

#将当天的英文月、数字日期、数字年作为变量赋值给d_mdy
d_mdy=`date "+%b %d, %Y"`

#判断参数个数
if [ $# -ne 2 ] && [ $# -ne 3 ]
then
    echo "你提供的参数个数不对，请提供2个或者3个参数。例：sh $0 t1 08:01:00 14:00:00" 
    exit 1
fi

#判断第一个参数是否符合要求
if ! echo $1|grep -qE '^t1$|^t2$|^t3$|^t4$'
then
    echo "第一个参数必须是t1、t2、t3或t4"
    exit 1
fi 

#判断时间有效性
judge_time()
{
    date -d "$1" +%s &>/dev/null
    if [ $? -ne 0 ]
    then
        echo "你提供的时间$1格式不正确"
        exit 1
    fi
}

#将24小时制时间转换为12小时
tr_24_12()
{
    date -d "$1" +%r
}

#判断提供的时间点是否在日志中出现
judge_time_in_log()
{
    if ! grep -q "$d_mdy $(tr_24_12 $1)" $logfile
        then
            echo "你提供的时间$1在日志$logfile中不曾出现，请换一个时间点"
            exit 1
        fi    
}

#判断第2个参数是否合法
judge_time $2

#判断起始时间点是否出现在日志里
judge_time_in_log $2

#如果提供第3个参数
if [ $# -eq 3 ]
then
    #判断第3个参数是否合法
    judge_time $3

    #判断起始时间是否早于结束时间
    t1=`date -d "$2" +%s`
        t2=`date -d "$3" +%s`
        if [ $t2 -lt $t1 ]
        then
            echo "你提供的时间$2比$3要晚，应该把早的时间放到前面"
            exit
        fi

        #判断提供的结束时间点是否出现在日志中
        judge_time_in_log $3
fi


#取起始时间所在行行号
begin_n=`grep -n "$d_mdy $(tr_24_12 $2)" $logfile|head -1|awk -F ':' '{print $1}'`

#取结束时间所在行行号，并用sed截取日志内容
if [ $# -eq 3 ]
then
    n=`grep -n "$d_mdy $(tr_24_12 $3)" $logfile|tail -1|awk -F ':' '{print $1}'`
    #结束日期所在行的下一行才是日志的内容
    end_n=$[$n+1]
    sed -n "$begin_n,$end_n"p $logfile
else
    sed -n "$begin_n,$"p $logfile
fi
