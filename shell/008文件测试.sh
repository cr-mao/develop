#!/bin/bash

test -f file && echo true || echo false 

# 也可以是 [] 
[ -f file ] && echo 1 || echo 0


# 文件测试操作符
# -d  是否是目录
# -a  目录或者文件是否存在
# -f 是否是文件
# -r, -w ,-x  是否可读可写








