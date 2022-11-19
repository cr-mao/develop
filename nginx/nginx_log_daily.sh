#!/bin/bash

#crontab
#nginx log daily
#1 0 * * * sudo /bin/bash /opt/scripts/nginx_log_daily.sh
# directory is %Y%m, for example 20220824 凌晨1分的时候，就会切割出  /var/log/nginx/202208/nginx_analysis_23.log

base_path='/var/log/nginx'
log_path=$(date -d yesterday +"%Y%m")
day=$(date -d yesterday +"%d")
mkdir -p $base_path/$log_path
mv $base_path/access.log $base_path/$log_path/access_$day.log
mv $base_path/nginx_analysis.log $base_path/$log_path/nginx_analysis_$day.log
/usr/sbin/nginx -s reload










