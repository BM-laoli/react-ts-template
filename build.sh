#!/bin/bash
##############################################################
# 如果 container 不存在就创建 如果存在就update
##############################################################
docker stop gitlab-runner-ci

docker container rm -f $( docker ps -aq --no-trunc  --filter name=gitlab-runner-ci)

if [[ "$?" -eq '0' ]]; then
  docker container run --name=gitlab-runner-ci -d -p 3002:3002 gitlab-runner-ci-test
  echo "更新成功"
else
  docker container run --name=gitlab-runner-ci -d -p 3002:3002 gitlab-runner-ci-test
  echo "初始化成功"
fi

echo "部署完成"

# 发送飞书通知，后续需要写一个服务 集成 自己的 账户体系
curl --location --request POST 'https://open.feishu.cn/open-apis/bot/v2/hook/d360428e-f5f7-41ae-8f7d-3418298ed99f' \
--header 'Content-Type: application/json' \
--data-raw '{
    "msg_type": "post",
    "content": {
        "post": {
            "zh_cn": {
                "title": "项目更新通知",
                "content": [
                    [
                        {
                            "tag": "text",
                            "text": "项目有更新: "
                        },
                        {
                            "tag": "a",
                            "text": "请查看",
                            "href": "http://192.168.1.5/big_ef/gitlab_test_ci"
                        }
                    ]
                ]
            }
        }
    }
}'
