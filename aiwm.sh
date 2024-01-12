#! /bin/bash

# check if don't exists file front-page.php
if [ ! -f "front-page.php" ]; then
    echo "File front-page.php not found!"
    exit 1
fi 


function downloadBackup(){
  cd ../../ai1wm-backups

  current_files=$(ls | grep '\.wpress')
  echo "Current files: $current_files"
  wp ai1wm backup
  # last_file=$(ls -t | head -n1)
  # echo "Last file: $last_file"
  echo "${tgreen}Backup created!${treset}"
  
}

downloadBackup
