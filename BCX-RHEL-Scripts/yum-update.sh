#!/bin/bash

# Check if the server is subscribed
if sudo subscription-manager status | grep -q -e "Content Access Mode is set to Simple Content Access. This host has access to content, regardless of subscription status." -e "Overall Status: Current"; then
    echo "Server is registered. Proceeding with yum update."
    # Perform yum update, suppress standard output but keep errors
    if sudo yum update -y > /dev/null 2>&1; then
       echo "Yum update completed successfully."
       echo "Yum update completed. Scheduling reboot."
       # Schedule the reboot for 1 minute later to allow Jenkins to finish the script
       sudo shutdown -r
       echo "Update completed. Server will reboot in 1 minute."
       echo "Jenkins job should disconnect now."
    else
       echo "Yum update failed. Please check the error messages above." >&2  # Send this to stderr to ensure Jenkins catches the error
       exit 1  # Explicitly exit with an error status if yum update fails
    fi
else
    echo "Server is not registered with the Satellite." >&2  # Send this to stderr
    exit 1
fi

# Clean up script file
rm -rf /tmp/yum-update.sh
