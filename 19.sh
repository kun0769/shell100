#!/bin/bash
#
#program:
#    显示最常用的命令
#
#history:
#2019/09/18    kun    V1.0

cat ~/.bash_history |sort |uniq -c|sort -nr|head -10
