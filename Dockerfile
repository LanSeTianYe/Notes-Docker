# docker 像源文件
# https://github.com/ProjectTemplate/docker-image-template/blob/main/alpine_3_21/python_3_10_16/mkdocs_git_nginx/Dockerfile
FROM sunfeilong1993/mkdocs-git-nginx:0.0.2

# 设置工作目录，统一所有项目为 www
WORKDIR /home/www

# 复制文件
COPY [".", "/home/www"]

# 创建 nginx 日志目录 和项目日志目录
RUN mkdir -p /home/logs

VOLUME ["/home/logs"]

# 启动服务
CMD ["./start.sh"]