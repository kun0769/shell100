#!/bin/bash
#
#program:
#    将用户家目录（考虑到执行脚本的用户可能是普通用户也可能是root）下面小于5KB的文件打包成tar.gz的压缩包，并以当前日期为文件名前缀
#    例如，2018-03-15.tar.gz
#
#history:
#2020/02/09    kun    V1.0

day=`date +%F`

cd $HOME
tar zcf $day.tar.gz `find ./ -type f -size -5k|xargs`
