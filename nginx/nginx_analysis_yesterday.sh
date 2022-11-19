#!/bin/bash

#crontab
#nginx analysis  注意时间要比 nginx_log_daily 要后面点
#1 1 * * * sudo /bin/bash /opt/scripts/nginx_analysis_yesterday.sh >> /tmp/nginx_analysis_shell.log 2>&1

# 400,401,402,403,404,405,408,422,500,502,504,503 此状态为异常状态码

base_path='/var/log/nginx'
log_path=$(date -d yesterday +"%Y%m")
day=$(date -d yesterday +"%d")
cd $base_path/$log_path
log_name="nginx_analysis_$day.log"
# todo fix this name
this_host_name='local'

a_total_count=`awk '{printf $1"\n"}' $log_name | grep "a.com" | wc -l`
b_total_count=`awk '{printf $1"\n"}'  $log_name | grep "b.com" | wc -l`
c_total_count=`awk '{printf $1"\n"}'  $log_name | grep "c.com" | wc -l`
d_total_count=`cat $log_name  | grep -E "/v1/time_sync" | wc -l`

total_count=$(($a_total_count+$b_total_count+$c_total_count+$d_total_count))
a_not_200_count=`awk '{if($6!=200) print $1}'  $log_name | grep "a.com" | wc -l`
b_not_200_count=`awk '{if($6!=200) print $1}'  $log_name | grep "b.com" | wc -l`
c_not_200_count=`awk '{if($6!=200) print $1}'  $log_name | grep "c.com" | wc -l`
d_not_200_count=`awk '{if($6!=200) print $1$4}'  $log_name | grep "d.com/v1/time_sync" | wc -l`
total_not_200_count=$(($a_not_200_count+$b_not_200_count+$c_not_200_count+$d_not_200_count))

a_500_count=`awk '{print $1$6}'  $log_name | grep -E "a.com500|a.com501|a.com502|a.com503|a.com504" | wc -l`
a_400_count=`awk '{print $1$6}'  $log_name | grep -E "a.com400|a.com401|a.com402|a.com403|a.com404|a.com405|a.com408|a.com422" | wc -l`
b_500_count=`awk '{print $1$6}'  $log_name | grep -E "b.com500|b.com501|b.com502|b.com503|b.com504" | wc -l`
b_400_count=`awk '{print $1$6}'  $log_name | grep -E "b.com400|b.com401|b.com402|b.com403|b.com404|b.com405|b.com408|b.com422" | wc -l`
c_500_count=`awk '{print $1$6}'  $log_name | grep -E "c.com500|c.com501|c.com502|c.com503|c.com504" | wc -l`
c_400_count=`awk '{print $1$6}'  $log_name | grep -E "c.com400|c.com401|c.com402|c.com403|c.com404|c.com405|c.com408|c.com422" | wc -l`




if [ $total_count -gt 0 ];then
  total_not_200_rate=`awk "BEGIN{printf \"%0.4f\", $total_not_200_count/$total_count}"`
  a_not_200_rate=0
  b_not_200_rate=0
  c_not_200_rate=0
  d_not_200_rate=0

  if [ $a_total_count -gt 0 ] && [ $a_not_200_count -gt 0 ];then
      a_not_200_rate=`awk "BEGIN{printf \"%0.4f\", $a_not_200_count/$a_total_count}"`
  fi

  if [ $b_total_count -gt 0 ] && [ $b_not_200_count -gt 0 ];then
      b_not_200_rate=`awk "BEGIN{printf \"%0.4f\", $b_not_200_count/$b_total_count}"`
  fi

  if [ $c_total_count -gt 0 ] && [ $c_not_200_count -gt 0 ];then
      c_not_200_rate=`awk "BEGIN{printf \"%0.4f\", $c_not_200_count/$c_total_count}"`
  fi

   if [ $d_total_count -gt 0 ] && [ $d_not_200_count -gt 0 ];then
       d_not_200_rate=`awk "BEGIN{printf \"%0.4f\", $d_not_200_count/$d_total_count}"`
   fi


  curl --location --request POST '飞书url' \
  --header 'Content-Type: application/json' \
  --data-raw '{
              	"msg_type": "post",
              	"content": {
              		"post": {
              			"zh_cn": {
              				"title": "'$this_host_name' '$log_path''$day' py游戏http-code统计",
              				"content": [
              					[{
              							"tag": "text",
              							"text": "总数:"
              						},
              						{
                                  "tag": "a",
                                  "text": "'$total_count'",
                                  "href": "javascript:void(0)"
                          },
                          {
                          		 "tag": "text",
                               "text": ",异常数:"
                          },
                          {
                                "tag": "a",
                                "text": "'$total_not_200_count'",
                                "href": "javascript:void(0)"
                           },
                           {
                                 "tag": "text",
                                 "text": ",非200比:"
                           },
                           {
                                 "tag": "a",
                                 "text": "'$total_not_200_rate'",
                                 "href": "javascript:void(0)"
                            }
              					  ],
              					   [
                            {
                              "tag": "text",
                              "text": "c.com总数:"
                            },
                             {
                                "tag": "a",
                                "text": "'$c_total_count'",
                                "href": "javascript:void(0)"
                             },
                              {
                                  "tag": "text",
                                  "text": " 非200:"
                               },
                               {
                                  "tag":"a",
                                  "text":"'$c_not_200_count'",
                                  "href": "javascript:void(0)"
                               },
                               {
                                   "tag": "text",
                                  "text": " 500系列:"
                               },
                               {
                                  "tag":"a",
                                  "text":"'$c_500_count'",
                                  "href": "javascript:void(0)"
                               },
                              {
                                 "tag": "text",
                                 "text": " 400系列:"
                              },
                              {
                                 "tag":"a",
                                 "text":"'$c_400_count'",
                                 "href": "javascript:void(0)"
                              },
                              {
                                   "tag": "text",
                                   "text": " 非200比:"
                            },
                           {
                               "tag":"a",
                               "text":"'$c_not_200_rate'",
                               "href": "javascript:void(0)"
                            }
                          ],
              		       [
              						{
                            "tag": "text",
                            "text": "a.com总数:"
                          },
                           {
                              "tag": "a",
                              "text": "'$a_total_count'",
                              "href": "javascript:void(0)"
                           },
                            {
                                "tag": "text",
                                "text": " 非200:"
                             },
                             {
                                "tag":"a",
                                "text":"'$a_not_200_count'",
                                "href": "javascript:void(0)"
                             },
                             {
                                 "tag": "text",
                                "text": " 500系列:"
                             },
                             {
                                "tag":"a",
                                "text":"'$a_500_count'",
                                "href": "javascript:void(0)"
                             },
                            {
                               "tag": "text",
                               "text": " 400系列:"
                            },
                            {
                               "tag":"a",
                               "text":"'$a_400_count'",
                               "href": "javascript:void(0)"
                            },
                            {
                                 "tag": "text",
                                 "text": " 非200比:"
                          },
                         {
                             "tag":"a",
                             "text":"'$a_not_200_rate'",
                             "href": "javascript:void(0)"
                          }
                        ],
                         [
                            {
                              "tag": "text",
                              "text": "b.com总数:"
                            },
                             {
                                "tag": "a",
                                "text": "'$b_total_count'",
                                "href": "javascript:void(0)"
                             },
                              {
                                  "tag": "text",
                                  "text": ",非200:"
                               },
                               {
                                  "tag":"a",
                                  "text":"'$b_not_200_count'",
                                  "href": "javascript:void(0)"
                               },
                               {
                                   "tag": "text",
                                  "text": ",500系列:"
                               },
                               {
                                  "tag":"a",
                                  "text":"'$b_500_count'",
                                  "href": "javascript:void(0)"
                               },
                             {
                                 "tag": "text",
                                 "text": ",400系列:"
                              },
                              {
                                 "tag":"a",
                                 "text":"'$b_400_count'",
                                 "href": "javascript:void(0)"
                              },
                              {
                                   "tag": "text",
                                   "text": ",非200比:"
                            },
                           {
                               "tag":"a",
                               "text":"'$b_not_200_rate'",
                               "href": "javascript:void(0)"
                            }
                          ],
                            [
                                                      {
                                                        "tag": "text",
                                                        "text": "lovep总数:"
                                                      },
                                                       {
                                                          "tag": "a",
                                                          "text": "'$d_total_count'",
                                                          "href": "javascript:void(0)"
                                                       },
                                                        {
                                                            "tag": "text",
                                                            "text": ",非200:"
                                                         },
                                                         {
                                                            "tag":"a",
                                                            "text":"'$d_not_200_count'",
                                                            "href": "javascript:void(0)"
                                                         },
                                                        {
                                                             "tag": "text",
                                                             "text": ",非200比:"
                                                      },
                                                     {
                                                         "tag":"a",
                                                         "text":"'$d_not_200_rate'",
                                                         "href": "javascript:void(0)"
                                                      }
                                                    ]
              				]
              			}
              		}
                     }
              	}'

fi





