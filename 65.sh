#!/bin/bash
#
#program:
#    已知下面的字符串是通过RANDOM随机数变量取md5sum|cut -c 1-8截取后的结果，请破解这些字符串对应的md5sum前的RANDOM对应数字？
#    21029299
#    00205d1c
#    a3da1677
#    1f6d12dd
#    890684ba
#
#history:
#2020/02/12    kun    V1.0

for num in {0..32767}
do
    n=`echo $num |md5sum |cut -c 1-8`
    echo $num $n
done > 65.tmp

cat > file.txt <<EOF
21029299
00205d1c
a3da1677
1f6d12dd
890684ba
EOF

grep -f file.txt 65.tmp
