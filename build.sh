#!/bin/bash
##############################################################
# 如果 container 不存在就创建 如果存在就update
##############################################################
docker run update --restart=always -d -p 3002:3002 gitlab-runner-ci-test

if [[ "$?" -eq '0' ]]; then
  echo "更新成功"
else
  echo "更新失败"
fi
