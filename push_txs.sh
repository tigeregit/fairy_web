#!/bin/bash

set -e  # 出错即终止

# 本地变量
TAR_FILE="public.tar.gz"
SOURCE_DIR="public"

# 生成 public 目录
echo "生成 $SOURCE_DIR ..."
hexo generate


# 压缩 public 目录
echo "压缩 $SOURCE_DIR 为 $TAR_FILE ..."
tar -czvf "$TAR_FILE" "$SOURCE_DIR"

# 传输 tar.gz 到远程 txs 主机
echo "上传 $TAR_FILE 到 txs ..."
scp "$TAR_FILE" txs:~

# 远程执行 update.sh
echo "在 txs 上执行 update.sh ..."
ssh txs 'bash ~/update.sh'

echo "✅ push 完成"