#!/bin/zsh

#===== desired-countを0とした上で、ECSサービスを更新=====
aws ecs update-service --cluster example-prod-foobar --service example-prod-foobar --desired-count 1
