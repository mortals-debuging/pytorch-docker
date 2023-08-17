#!/bin/bash

ssh_command="service ssh start"
bashrc_file="/root/.bashrc"
ssh_config_file="/etc/ssh/sshd_config" # 注意：这里应该是sshd_config，而不是ssh_config
root_login_option="PermitRootLogin yes"

# 检查"service ssh start"命令是否存在于/root/.bashrc
if grep -q "^$ssh_command" "$bashrc_file"; then
    echo "SSH is set to start automatically."
else
    echo "Adding SSH startup command to /root/.bashrc."
    echo "$ssh_command" >> "$bashrc_file"
    service ssh start
    printf "\e[1;31;7mPlease set your password! \nPlease set your password! \nPlease set your password! \e[0m\n"
    passwd

    # 检查PermitRootLogin是否设置为yes
    if grep -q "^$root_login_option" "$ssh_config_file"; then
        echo "Root login is already enabled. Skipping..."
    else
        echo "Enabling root login."
        # 如果存在PermitRootLogin行，则替换为yes
        if grep -q "^PermitRootLogin" "$ssh_config_file"; then
            sed -i "s/^PermitRootLogin.*/$root_login_option/" "$ssh_config_file"
        else
            # 如果不存在，则添加PermitRootLogin yes到文件末尾
            echo "$root_login_option" >> "$ssh_config_file"
        fi
        echo "Root login has been enabled."
        service ssh restart # 重新启动SSH服务以应用更改
    fi
fi