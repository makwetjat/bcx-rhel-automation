#!/bin/bash

# Check if OpenJDK is installed
installed_jdk=$(sudo yum list installed | grep java-1.8.0-openjdk)

if [[ -z "$installed_jdk" ]]; then
    echo "No OpenJDK 1.8.0 is installed."
    exit 0
fi

# Extract the installed version of OpenJDK
jdk_version=$(sudo yum list installed | grep java-1.8.0-openjdk | awk '{print $2}' | cut -d'-' -f1)

# Check if the version is 1.8.0.4* or higher
if [[ "$jdk_version" =~ ^1\.8\.0\.4[0-9]+$ ]]; then
    echo "OpenJDK version $jdk_version found, removing..."
    
    # Remove java-1.8.0-openjdk and related packages
    sudo yum remove -y java-1.8.0-openjdk java-1.8.0-openjdk-devel java-1.8.0-openjdk-headless

    echo "OpenJDK version $jdk_version has been removed."
else
    echo "OpenJDK version $jdk_version does not match 1.8.0.4* or higher. No action taken."
fi
