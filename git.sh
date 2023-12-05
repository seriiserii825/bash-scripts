#! /bin/bash

args=("$@")

function gitUpdateAll(){
  date_now=$(date +"%Y-%m-%d %H:%M:%S")
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

select action in "nvim" "clipboard" "update"
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
        *)
            echo "Invalid option"
            ;;
    esac
done
