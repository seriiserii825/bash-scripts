#! /bin/bash

args=("$@")

date_now=$(date +"%Y-%m-%d %H:%M:%S")
function gitUpdateAll(){
  dirs=(~/Documents/Knowledge-base ~/xubuntu ~/.password-store ~/.config/nvim ~/i3wm-home ~/i3wm-office ~/Documents/bash-scripts ~/Documents/bash-apps ~/Documents/bash-private)
  for dir in "${dirs[@]}"; do
    echo "=========================================="
    echo "Update for $dir"
    cd $dir
    git add .
    git commit -m "updated by script at $date_now"
    git pull
    git push
    echo "=========================================="
  done
}

function removeStagged(){
  projects_list=$(mgitstatus -e -d 4)
  touch ~/Downloads/list.txt
  echo "${projects_list[@]}" > ~/Downloads/list.txt
  bat ~/Downloads/list.txt
  while read -r line; do
    file_name=$(echo "$line" | cut -d ':' -f 1)
    cd $file_name
    git restore .
    git clean -fd
    cd - > /dev/null
  done < ~/Downloads/list.txt

  rm ~/Downloads/list.txt
}

select action in "nvim" "clipboard" "update" "remove_stagged"
do
  case $action in
    nvim)
      $(git log --pretty="%C(Yellow)%h  %C(reset)%ad (%C(Green)%cr%C(reset))%x09 %C(Cyan)%an: %C(reset)%s" --date=short -30 --reverse > log.log)
      bat log.log
      break
      ;;
    clipboard)
      log=$(git log --since="3am" --pretty=tformat:"%s" --reverse > log.log);
      cat log.log | xclip -selection clipboard
      rm log.log
      break
      ;;
    update)
      gitUpdateAll
      break
      ;;
    remove_stagged)
      removeStagged
      break
      ;;
    *)
      echo "Invalid option"
      ;;
  esac
done
