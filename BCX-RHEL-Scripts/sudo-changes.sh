#!/bin/bash

# Variables for the users and the sudoers rules
user1="tooladm"
user2="bastion"
rule1="$user1 ALL=NOPASSWD:ALL"
rule2="$user2 ALL=NOPASSWD:ALL"

# Backup the sudoers file
sudo cp /etc/sudoers /etc/sudoers.bak

# Function to check if a rule exists in both /etc/sudoers and /etc/sudoers.d
check_and_add_rule() {
    local user="$1"
    local user_rule="$2"
    if sudo grep -qP "^\s*${user}\s+" /etc/sudoers || sudo grep -qP "^\s*${user}\s+" /etc/sudoers.d/*; then
        echo "A rule for $user already exists in /etc/sudoers or /etc/sudoers.d. Skipping."
    else
        echo "$user_rule" | sudo tee -a /etc/sudoers
        echo "Rule for $user added to sudoers."
    fi
}

# Check and add rules for tooladm and bastion
check_and_add_rule "$user1" "$rule1"
check_and_add_rule "$user2" "$rule2"

# Validate sudoers file syntax
sudo visudo -c

if [ $? -eq 0 ]; then
    echo "Sudoers file is valid."
else
    echo "Sudoers file is invalid! Restoring backup."
    sudo cp /etc/sudoers.bak /etc/sudoers
fi
