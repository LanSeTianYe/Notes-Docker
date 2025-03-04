FROM sunfeilong1993/mkdocs-git-nginx:0.0.1

# 设置工作目录，统一所有项目为 www
WORKDIR /home/www

# 复制文件
COPY [".", "/home/www"]

# 安装依赖
# 创建 nginx 日志目录 和项目日志目录
RUN mkdir -p /home/logs/nginx && mkdir -p /home/logs/www

# 启动服务
CMD ["./start.sh"]