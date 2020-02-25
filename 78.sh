#!/bin/bash
#
#program:
#    格式化输出文本
#
#history:
#2020/02/25    kun    V1.0

cat > 78.txt <<EOF
1111111:13443253456
2222222:13211222122
1111111:13643543544
3333333:12341243123
2222222:12123123123
EOF

#遍历第一段内容，获得所有关联的第二段
for w in `awk -F ':' '{print $1}' 78.txt |sort |uniq`
do
    echo "[$w]"
    #awk引用shell变量要使用-v重新定义新变量来接收
    awk -v j=$w -F ':' '$1==j {print $2}' 78.txt
done
