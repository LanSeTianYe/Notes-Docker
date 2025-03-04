FROM python:3.10.16-alpine3.21

# 设置工作目录
WORKDIR /home/www

# 复制文件
COPY [".", "/home/www"]

# 安装依赖 
RUN mkdir -p /home/logs/nginx && \
    # 创建 nginx 日志目录
    mkdir -p /home/logs/www && \
    # 创建 项目 日志目录（统一使用 www 简化项目配置）
    apk update && \
    apk add git && \
    apk add nginx && \
    pip install mkdocs && \
    pip install mkdocs-material && \
    pip install mkdocs-git-revision-date-localized-plugin && \
    pip install mkdocs-awesome-pages-plugin && \
    pip install mkdocs-git-committers-plugin-2 && \
    pip install mkdocs-git-authors-plugin && \
    pip install mkdocs-git-revision-date-localized-plugin

# 启动服务
CMD ["./start.sh"]