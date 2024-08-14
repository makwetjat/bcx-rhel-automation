#!/bin/bash

# Stop the auditd service
sudo service auditd stop

# Define the patterns to check and their replacements
pattern1="^admin_space_left_action = rotate"
replacement1="admin_space_left_action = rotate"
pattern2="^max_log_file_action = rotate"
replacement2="max_log_file_action = rotate"

# Check and update the first pattern if not already present
if ! sudo grep -q "$pattern1" /etc/audit/auditd.conf; then
    echo "Updating admin_space_left_action in auditd.conf"
    sudo sed -i 's/^admin_space_left_action = halt/admin_space_left_action = rotate/' /etc/audit/auditd.conf
else
    echo "admin_space_left_action is already set to rotate"
fi

# Check and update the second pattern if not already present
if ! sudo grep -q "$pattern2" /etc/audit/auditd.conf; then
    echo "Updating max_log_file_action in auditd.conf"
    sudo sed -i 's/^max_log_file_action = keep_logs/max_log_file_action = rotate/' /etc/audit/auditd.conf
else
    echo "max_log_file_action is already set to rotate"
fi

# Start the auditd service
sudo service auditd start

echo "auditd service has been restarted with the updated configuration."

rm -rf /tmp/rhel-auditd-parameters
