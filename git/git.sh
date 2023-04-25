#!/bin/bash
git config --global user.name "cr-mao"    # 用户名改成自己的
git config --global user.email "crmao@qq.com"    # 邮箱改成自己的
git config --global credential.helper store    # 设置 git，保存用户名和密码
git config --global core.longpaths true # 解决 Git 中 'Filename too long' 的错误


# 在 Git 中，我们把非 ASCII 字符叫作 Unusual 字符。这类字符在 Git 输出到终端的时候默认是用 8 进制转义字符输出的（以防乱码），但现在的终端多数都支持直接显示非 ASCII 字符，所以我们可以关闭掉这个特性，具体的命令如下：

git config --global core.quotepath off

# GitHub 限制最大只能克隆 100M 的单个文件，为了能够克隆大于 100M 的文件，我们还需要安装 Git Large File Storage

git lfs install --skip-repo


