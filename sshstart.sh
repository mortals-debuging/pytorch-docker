#!/bin/bash

ssh_command="service ssh start"
profile_file="/etc/profile"
root_profile_file="/root/.profile"
ssh_config_file="/etc/ssh/ssh_config"
use_pam_option="UsePAM no"

# Check if the "service ssh start" command is present in /etc/profile or /root/.profile
if grep -q "^$ssh_command" "$profile_file" || grep -q "$ssh_command" "$root_profile_file"; then
    echo "SSH is set to start automatically."
else
    echo "Adding SSH startup command to /etc/profile."
    echo "$ssh_command" >> "$profile_file"
    printf "\e[1;31;7mPlease set your password! \nPlease set your password! \nPlease set your password! \e[0m\n"
    read -p "Do you want to set a password now? (y/n) " choice
    if [[ $choice == "y" || $choice == "Y" || $choice == "" ]]; then
        sudo passwd "$(whoami)"
    else
        echo "Password setup canceled."
        exit 1
    fi
fi