#!/bin/bash

# Disable folder permissions for Tencent apps to prevent xlog file writing

WECHAT_CACHE_DIR="$HOME/Library/Containers/com.tencent.xinWeChat/Data/Library/Caches/com.tencent.xinWeChat"
QQ_CACHE_DIR="$HOME/Library/Containers/com.tencent.qq/Data/Library/Caches/com.tencent.qq"
WECHAT_APPLET_DIR="$HOME/Library/Containers/com.tencent.xinWeChat/Data/.wxapplet/xlog"

disable_write_permissions() {
    local dir="$1"
    if [ -d "$dir" ]; then
        chmod -R a-w "$dir"
        echo "Write permissions disabled for: $dir"
    else
        echo "Directory not found: $dir"
    fi
}

echo "Disabling folder permissions for Tencent apps (WeChat and QQ) to prevent xlog file writing..."

disable_write_permissions "$WECHAT_CACHE_DIR"
disable_write_permissions "$QQ_CACHE_DIR"
disable_write_permissions "$WECHAT_APPLET_DIR"

echo "Operation completed."
