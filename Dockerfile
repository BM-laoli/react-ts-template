# 获取node环境
# 获取npm
# 获取serve
# cv build文件 
# 执行run 命令

# ssh 容器跑起来
FROM node:alpine
COPY ./build /app
WORKDIR /app
RUN npm config set registry https://registry.npm.taobao.org 
RUN npm install serve -g
CMD serve . -p 3002 

EXPOSE 3002

