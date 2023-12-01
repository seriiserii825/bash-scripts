#!/bin/bash

read -p "Enter the name of the directory: " download_dir_name;
dir_path=~/Downloads/$download_dir_name;
mkdir -p $dir_path;

LIST="$(find . -mindepth 1 -maxdepth 1 -type d)";
while test -n "$LIST"; do
    for D in $LIST; do
      dir_name=$(basename $D);
      echo $dir_name;
      if [ $dir_name != '.git' ]; then
        cd $dir_name;
        files="$(find . -mindepth 1 -maxdepth 1 -type f)";
        for file in $files; do
          file_name=$(basename $file);
          # echo $file_name;
          base_file_name=${file_name%.*}
          # echo $base_file_name;
          file_extention=${file_name##*.}
          # echo $file_extention;
          result_name="$base_file_name-$dir_name.$file_extention";
          # echo $result_name;
          mv $file_name $result_name; 
          mv $result_name $dir_path;
        done;
        cd ..;
      fi
    done;
    LIST=$NLIST;
    NLIST="";
done
