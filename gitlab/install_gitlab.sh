#!/bin/bash
#
#********************************************************************
#Author:            cr-mao 
#Date:              2020-02-10
#FileName:          install_gitlab.sh
#URL:               http://www.crblogcc.com
#Description:       The test script
#Copyright (C):     2020 All rights reserved
#********************************************************************

#说明:安装GitLab 服务器内存建议至少4G,root密码至少8位

GITLAB_VERSION=15.1.2
#GITLAB_VERSION=14.1.7
#GITLAB_VERSION=12.3.5
. /etc/os-release

UBUNTU_URL="https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/ubuntu/pool/${UBUNTU_CODENAME}/main/g/gitlab-ce/gitlab-ce_${GITLAB_VERSION}-ce.0_amd64.deb"
RHEL_URL=https://packages.gitlab.com/gitlab/gitlab-ce/packages/el/8/gitlab-ce-${GITLAB_VERSION}-ce.0.el8.x86_64.rpm
#RHEL_URL="https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/yum/el8/gitlab-ce-${GITLAB_VERSION}-ce.0.el8.x86_64.rpm"
#UBUNTU_URL="https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/ubuntu/pool/bionic/main/g/gitlab-ce/gitlab-ce_12.3.5-ce.0_amd64.deb"
#RHEL_URL="https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/yum/el7/gitlab-ce-14.1.5-ce.0.el7.x86_64.rpm"

HOST=gitlab.wang.org
DOWNLOAD_DIR=/usr/local/src
GITLAB_ROOT_PASSWORD=12345678
SMTP_PASSWORD=XLGWWWGMCVZSPDDY
#HOST=`hostname -I|awk '{print $1}'`


color () {
    RES_COL=60
    MOVE_TO_COL="echo -en \\033[${RES_COL}G"
    SETCOLOR_SUCCESS="echo -en \\033[1;32m"
    SETCOLOR_FAILURE="echo -en \\033[1;31m"
    SETCOLOR_WARNING="echo -en \\033[1;33m"
    SETCOLOR_NORMAL="echo -en \E[0m"
    echo -n "$1" && $MOVE_TO_COL
    echo -n "["
    if [ $2 = "success" -o $2 = "0" ] ;then
        ${SETCOLOR_SUCCESS}
        echo -n $"  OK  "    
    elif [ $2 = "failure" -o $2 = "1"  ] ;then 
        ${SETCOLOR_FAILURE}
        echo -n $"FAILED"
    else
        ${SETCOLOR_WARNING}
        echo -n $"WARNING"
    fi
    ${SETCOLOR_NORMAL}
    echo -n "]"
    echo 
}



install_gitlab() {
    if [ $ID = "centos" -o $ID = "rocky" ];then
        PACK="${RHEL_URL##*/}"
        echo $PACK
        [ ! -e $PACK ] && wget  ${RHEL_URL} || { color  "下载失败!" 1 ;exit ; }
        yum -y install $PACK
    elif [ $ID = "ubuntu" ];then
        PACK="${UBUNTU_URL##*/}"
        echo $PACK
        echo ${UBUNTU_URL}
        if [ ! -e $PACK ];then
             wget ${UBUNTU_URL} || { color  "下载失败!" 1 ;exit ; }
        fi
        dpkg -i  $PACK 
    else 
        color '不支持当前操作系统!' 1
        exit
    fi
    if [ $? -eq 0 ];then
        color "安装 GitLab完成!" 0
    else
        color "安装 GitLab失败!" 1
        exit
    fi
}
config_gitlab() {
    sed -i.bak  "/^external_url.*/c external_url \'http://$HOST\'" /etc/gitlab/gitlab.rb
    cat  >> /etc/gitlab/gitlab.rb <<EOF
gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = "smtp.qq.com"
gitlab_rails['smtp_port'] = 465
gitlab_rails['smtp_user_name'] = "29308620@qq.com"
gitlab_rails['smtp_password'] = "$SMTP_PASSWORD"
gitlab_rails['smtp_domain'] = "qq.com"
gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['smtp_tls'] = true
gitlab_rails['gitlab_email_from'] = "29308620@qq.com"
gitlab_rails['initial_root_password'] = "$GITLAB_ROOT_PASSWORD"
EOF
    gitlab-ctl reconfigure
    gitlab-ctl status
    if [ $?  -eq 0 ];then  
        echo 
        color "Gitlab安装完成!" 0
        echo "-------------------------------------------------------------------"
        echo -e "请访问链接: \E[32;1mhttp://$HOST/\E[0m" 
		echo -e "用户和密码: \E[32;1mroot/${GITLAB_ROOT_PASSWORD}\E[0m" 
    else
        color "Gitlab安装失败!" 1
        exit
    fi 
}


install_gitlab

config_gitlab
