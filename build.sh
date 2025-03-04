#!/bin/sh

# TODO: 请修改为你的【仓库地址】
git_repository="https://github.com/LanSeTianYe/Notes-Template.git"

if [[ ! -d "docs" ]];then
    echo "docs not exists, clone project start ..."
    git clone ${git_repository} docs
    echo "docs not exists, clone project end ..."
fi

echo "pull docs start ..."
cd docs && git pull
echo "pull docs end ..."
cd .. && mkdocs build




