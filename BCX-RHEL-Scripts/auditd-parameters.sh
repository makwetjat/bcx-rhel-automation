#!/bin/bash

# Define the patterns to check and their replacements
pattern1="^admin_space_left_action = rotate"
pattern2="^max_log_file_action = rotate"

# Flag to determine if changes are made
changes_made=false

# Check and update the first pattern if not already present
if ! sudo grep -q "$pattern1" /etc/audit/auditd.conf; then
    echo "Updating admin_space_left_action in auditd.conf"
    sudo sed -i 's/^admin_space_left_action = halt/admin_space_left_action = rotate/' /etc/audit/auditd.conf
    changes_made=true
else
    echo "admin_space_left_action is already set to rotate"
fi

# Check and update the second pattern if not already present
if ! sudo grep -q "$pattern2" /etc/audit/auditd.conf; then
    echo "Updating max_log_file_action in auditd.conf"
    sudo sed -i 's/^max_log_file_action = keep_logs/max_log_file_action = rotate/' /etc/audit/auditd.conf
    changes_made=true
else
    echo "max_log_file_action is already set to rotate"
fi

# Stop and start the auditd service only if changes were made
if [ "$changes_made" = true ]; then
    sudo service auditd stop
    sudo service auditd start
    echo "auditd service has been restarted with the updated configuration."
else
    echo "No changes were made. auditd service was not restarted."
fi

rm -rf /tmp/rhel-auditd-parameters

