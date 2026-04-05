#!/bin/bash
# This script helps cleaning up old backups of the configuration folder.
# Usage: ./clean-update.sh [--accept-all]
# Author: SgtMate

# Check if the --accept-all parameter is passed
ACCEPT_ALL=false
if [ "$1" == "--accept-all" ]; then
    ACCEPT_ALL=true
fi

# Directory to search for folders
TARGET_DIR="/data"

# Find all folders starting with "config_backup_"
folders=$(find "$TARGET_DIR" -maxdepth 1 -type d -name "config_backup_*")

# Check if any folders were found
if [ -z "$folders" ]; then
    echo "No folders starting with 'config_backup_' found in $TARGET_DIR."
    exit 0
fi

# Arrays to store deleted and kept folders
deleted_folders=()
kept_folders=()

if [[ $ACCEPT_ALL == true ]]; then
    for folder in $folders; do
        echo "Found folder: $folder"
        rm -rf "$folder"
        deleted_folders+=("$folder")
        echo "Deleted $folder."
    done
else
    # Iterate through each folder and prompt the user for deletion
    for folder in $folders; do
        echo "Found folder: $folder"
        read -p "Do you want to delete this folder? (y/n): " choice
        case "$choice" in
            y|Y)
                rm -rf "$folder"
                deleted_folders+=("$folder")
                echo "Deleted $folder."
                ;;
            n|N)
                kept_folders+=("$folder")
                echo "Skipped $folder."
                ;;
            *)
                echo "Invalid input. Skipping $folder."
                kept_folders+=("$folder")
                ;;
        esac
    done
fi

# List all deleted and kept folders
echo "Operation completed."
echo "Deleted folders:"
for folder in "${deleted_folders[@]}"; do
    echo "  $folder"
done

echo "Kept folders:"
for folder in "${kept_folders[@]}"; do
    echo "  $folder"
done
