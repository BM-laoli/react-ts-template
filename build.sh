#!/bin/bash
##############################################################
# 如果 container 不存在就创建 如果存在就update
##############################################################
docker stop gitlab-runner-ci

docker container rm -f $( docker ps -aq --no-trunc  --filter ancestor=gitlab-runner-ci-test)

if [[ "$?" -eq '0' ]]; then
  docker container run --name=gitlab-runner-ci -d -p 3002:3002 gitlab-runner-ci-test
  echo "更新成功"
else
  docker container run --name=gitlab-runner-ci -d -p 3002:3002 gitlab-runner-ci-test
  echo "初始化成功"
fi

echo "部署完成"
