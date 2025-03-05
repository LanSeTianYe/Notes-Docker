#!/bin/sh

# 进入工作目录
cd /home/www

git_repository="$1"

if [[ ! -d "docs" ]];then
    echo "docs not exists, clone project start ..."
    git clone ${git_repository} docs
    echo "docs not exists, clone project end ..."
fi

echo "pull docs start ..."
cd docs && git pull
echo "pull docs end ..."
cd .. && mkdocs build

