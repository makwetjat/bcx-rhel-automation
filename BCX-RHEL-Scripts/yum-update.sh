#!/bin/bash

# Check if the server is subscribed
if sudo subscription-manager status | grep -q -e "Content Access Mode is set to Simple Content Access. This host has access to content, regardless of subscription status." -e "Overall Status: Current"; then
    echo "Server is registered. Proceeding with yum update."
    # Perform yum update, suppress output but keep errors
    if sudo yum update -y > /dev/null; then
       echo "Yum update completed successfully."
    else
       echo "Yum update failed. Please check the error messages above."
       exit 1
    fi
    echo "Yum update completed. Scheduling reboot."
    # Schedule the reboot for 1 minute later to allow Jenkins to finish the script
    sudo shutdown -r
    echo "Update completed. Server will reboot in 1 minute."
    echo "Jenkins job should disconnect now."
else
    echo "Server is not registered with the Satellite."
    exit 1
fi

rm -rf /tmp/yum-update.sh
