#!/bin/bash
#
#program:
#    批量杀进程
#
#history:
#2019/09/21    kun    V1.0

ps aux|grep clearnen |grep -v grep|xargs kill -9
