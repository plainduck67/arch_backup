#!/bin/bash

echo "Choose an option:"
options=("Install packages" "Set configs" "All of the above" "Quit")

clear
select opt in "${options[@]}"; do
    case $opt in
        "Install packages")
            echo "installing packages..."
            bash installations.sh
            echo "completed"
            break
            ;;
        "Set configs")
            bash configs.sh
            break
            ;;
        "All of the above")
            echo "installing packages..."
            bash installations.sh
            echo "completed"

            echo "setting configs in place"
            bash configs.sh
            echo "completed"
            break
            ;;
        "Quit")
            echo "exiting..."
            break
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
done
