#!/bin/bash
#
#program:
#    把当前用户下所有进程名字中包含“ aming”的进程关闭
#
#history:
#2020/02/11    kun    V1.0

#进程名是最后一段 使用$NF表示
ps -u $USER|awk '$NF ~/aming/ {print $1}'|xargs kill -9
