#!/bin/bash

clipboard=$(xclip -o -selection clipboard)

select lang in "en" "it" "ru" "ro"
do
  case $lang in
    "en")
      trans -b :en "$clipboard" | tr -d '\n' | xsel -b -i 
      break
      ;;
    "it")
      trans -b :it "$clipboard"  | tr -d '\n' | xsel -b -i 
      break
      ;;
    "ru")
      trans -b :ru "$clipboard"  | tr -d '\n' | xsel -b -i 
      break
      ;;
    "ro")
      trans -b :ro "$clipboard"  | tr -d '\n' | xsel -b -i 
      break
      ;;
    *)
      echo "ERROR! Please select between 1..5";;
  esac
done

