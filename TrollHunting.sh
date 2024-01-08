######################################################################
# This was for a project where I was given a system with a "troll"   #
# script that would change files and compromise the file integrity   # 
# of the system. As I identified where the malware was ending up, I  #
# added and consolidated those directories in my scan until I had    #
# completely neutralized the troll throughout the system.            #
######################################################################

#!/bin/bash

echo "Troll! In the system! ...thought you oughta know... *faints*"

fileSecure=false
# Function to restore the original files from backups
restore_files() {
    echo "Restoring files!"
    cp /var/backups/shadow.bak /etc/shadow
    cp /var/backups/passwd.bak /etc/passwd
    cp /var/backups/group.bak /etc/group
    cp /var/backups/Confidential_Report.txt /home/blueteam/Confidential_Report.txt
}

# Continuously monitor files and restore them if changes are detected
while true; do
    if [ "$filesSecure" = true ]; then
        echo "No changes detected."
    else
        echo "Checking for changes in files..."
        filesSecure=true
    fi

    # Check /etc/shadow for changes
    if [ -n "$(sudo diff /etc/shadow /var/backups/shadow.bak)" ]; then
        echo "Troll detected in /etc/shadow!" 
        restore_files
    fi

    # Check /etc/passwd for changes
    if [ -n "$(sudo diff /etc/passwd /var/backups/passwd.bak)" ]; then
        echo "Troll detected in /etc/passwd!"
        restore_files
    fi

    # Check /etc/group for changes
    if [ -n "$(sudo diff /etc/group /var/backups/group.bak)" ]; then
        echo "Troll detected in /etc/group!"
        restore_files
    fi

    # Check /home/blueteam/Confidential_Report.txt for changes
    if [ -n "$(sudo diff /home/blueteam/Confidential_Report.txt /var/backups/Confidential_Report.txt)" ]; then
        echo "Troll detected in /home/blueteam/Confidential_Report.txt!"
        restore_files
    fi

    # Sleep for 2 seconds before the next check
    sleep $(2)
done
