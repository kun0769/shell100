#!/bin/bash
#
#program:
#    请把下面的字符串：
#       zhangsan
#       y97JbzPru
#       lisi
#       5JhvCls6q
#       xiaowang
#       Nnr8qt2Ma
#       laoma
#       iqMtvC02y
#       zhaosi
#       9fxrb4sJD
#    改为如下：
#       zhangsan:y97JbzPru
#       lisi:5JhvCls6q
#       xiaowang:Nnr8qt2Ma
#       laoma:iqMtvC02y
#       zhaosi:9fxrb4sJD
#history:
#2020/03/18    kun    V1.0

cat > 1.txt <<EOF
zhangsan
y97JbzPru
lisi
5JhvCls6q
xiaowang
Nnr8qt2Ma
laoma
iqMtvC02y
zhaosi
9fxrb4sJD
EOF

# n是总行数
n=`cat 1.txt |wc -l`

# i是奇数行 j是偶数行
i=1
while [ $i -lt $n ]
do
    j=$[$i+1]
    i_line=`sed -n "${i}p" 1.txt`
    j_line=`sed -n "${j}p" 1.txt`
    echo "$i_line:$j_line"
    i=$[$i+2]
done

rm -rf 1.txt
