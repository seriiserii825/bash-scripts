#!/bin/bash
cd ~/Downloads
md_path=~/Downloads/index.md
html_path=~/Downloads/index.html
touch $md_path
touch $html_path

echo "$(xclip -o -selection clipboard)" > $md_path
# bat $md_path
pandoc -f markdown index.md > index.html
# bat $html_path
xclip -selection clipboard $html_path


