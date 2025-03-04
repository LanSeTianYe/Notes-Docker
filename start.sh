#!/bin/sh

# 运行重新构建服务
# 绑定的 IP
host="127.0.0.1"
# 绑定的端口
port=8888
# 校验key
# TODO 请修改成你的【auth_key】
auth_key="00000000839a8e6886ab5951d76f411475428afc90947ee320161bbf18eb6048"

nohup python /home/www/server.py ${host} ${port} ${auth_key} > /home/logs/www/rebuild.log 2>&1 &

# 运行 nginx
nginx -g 'daemon off;' -c /home/www/nginx.conf