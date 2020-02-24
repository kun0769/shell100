#!/bin/bash
#
#program:
#    请撰写一个shell函数，函数名为f_judge，实现以下功能
#    1)当/home/log目录存在时将/home目录下所有tmp开头的文件或目录移到/home/log目录
#    2)当/home/log目录不存在时，创建该目录，然后退出
#
#history:
#2020/02/24    kun    V1.0

f_judge()
{
    if [ -d /home/log/ ]
    then
        #find /home -name "tmp*" |xargs -i mv {} /home/log/
        find /home -name "tmp*" -exec mv {} /home/log/ \;
    else
        mkdir /home/log/
        exit
    fi
}

f_judge
