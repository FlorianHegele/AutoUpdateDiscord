#!/bin/bash

# Function to obtain the currently installed version of Discord
get_installed_version() {
    local installed_version=$(dpkg-query -W -f='${Version}\n' discord 2>/dev/null)
    echo $installed_version
}

# Function to get the latest version of Discord from the API
get_latest_version() {
    local latest_version_url="https://discord.com/api/download/stable?platform=linux&format=deb"
    local download_url=$(curl -sI $latest_version_url | grep -i '^location' | awk '{print $2}' | tr -d '\r\n')
    echo $download_url
}

# Function to download and install the latest version of Discord
update_discord() {
    local download_url=$1
    local temp_dir=$(mktemp -d)
    local filename=$(basename $download_url)
    local download_path="$temp_dir/$filename"

    echo "$temp_dir tmp dir"
    echo "$download_path path"
    
    echo "Download the latest version of Discord..."
    curl -# -L -o $download_path $download_url

    if [ -f $download_path ]; then
        echo "Installing the new version of Discord..."
        sudo dpkg -i $download_path
        rm $download_path

        echo "Discord has been successfully updated!"
    else
        echo "Failed to download the latest version of Discord."
    fi

    rm -rf $temp_dir
}

installed_version=$(get_installed_version)
latest_version_url=$(get_latest_version)

if [ -z "$installed_version" ]; then
    echo "Discord is not installed on this system."
    echo "Download and install the latest version of Discord..."
    update_discord $latest_version_url
    exit
fi

if [ -n "$latest_version_url" ]; then
    latest_version=$(echo "$latest_version_url" | cut -d '/' -f 6)
    if [[ "$installed_version" != "$latest_version" ]]; then
        echo "A new version of Discord is available. Update in progress..."
        update_discord $latest_version_url
    else
        echo "The currently installed version of Discord is already up to date."
    fi
else
    echo "Unable to get the latest version of Discord from the API."
fi