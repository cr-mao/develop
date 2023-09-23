#!/bin/bash
# -eq 等于
# -ne  不等于
# -gt  大于
# -lt  小于
# -le 小于或等于
# -ge 大于或等于

ip=10.18.42.1
i=1
while [ $i -le 5 ]
do 
    ping -c $ip &> /dev/null
    if [ $? -eq 0 ];then
	echo "$ip is up .... "
    fi
    let i++
done




# 关系运算符 
# == , !=, >, < ,>=,<=

((1<2)); echo $?
((1==2));echo $?
