#!/bin/bash

tesseract ~/Downloads/screen.jpg ~/Downloads/screen
sed '/^[[:space:]]*$/d' ~/Downloads/screen.txt | xclip -selection clipboard
# rm ~/Downloads/screen.jpg
# rm ~/Downloads/screen.txt


#bindsym $mod+ctrl+y exec --no-startup-id maim -f jpg -s ~/Downloads/screen.jpg && exec ~/Documents/bash-scripts/extract-text-from-image.sh
