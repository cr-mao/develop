#!/bin/bash
OLD_IFS=$IFS
IFS=$'\n' # for 循环默认以tab 空格 回车为换行符，改为行作为分隔符
for line in `cat /etc/hosts`
do
	hosts[++j]=$line
done

for i in ${!hosts[@]}
do
	echo "$i:${hosts[i]}"
done

