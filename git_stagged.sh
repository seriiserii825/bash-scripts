#! /bin/bash 

date_now=$(date +"%Y-%m-%d %H:%M:%S")
for dir in $(find . -type d -name ".git"); do
  cd "$dir/.."
  echo "dir: $dir"
  if [ -n "$(git status --porcelain)" ]; then
    git reset --hard
    git add .
    git commit -m "updated by script at $date_now"
    git pull
    git push
  fi  
  cd - > /dev/null
done
