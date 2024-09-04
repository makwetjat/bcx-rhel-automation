#!/bin/bash

ORGINIZATION_NAME=$1
ACTIVATION_KEY=$2

echo "Organization Name: ${ORGINIZATION_NAME}"
echo "Activation Key: ${ACTIVATION_KEY}"

# Countdown function
function countdown {
    local count=$1
    while [ $count -gt 0 ]; do
        echo -ne "Waiting for $count seconds... \r"
        sleep 1
        ((count--))
    done
    echo ""
}

# Check if the system is already registered
if sudo subscription-manager identity &>/dev/null; then
    echo "The system is already registered."
else
    # Register the system
    echo "Registering the system..."
    sudo subscription-manager clean
    sudo rpm -Uvh http://cdlh-rhel-sat1.telkom.co.za/pub/katello-ca-consumer-latest.noarch.rpm --force
    sudo subscription-manager register --org="$ORGINIZATION_NAME" --activationkey="$ACTIVATION_KEY" --force
    countdown 3
    sudo subscription-manager attach --auto
    sudo subscription-manager list

    # Check registration status
    if [ $? -eq 0 ]; then
        echo "Registration successful."
    else
        echo "Error: Registration failed."
        exit 1
    fi
fi
