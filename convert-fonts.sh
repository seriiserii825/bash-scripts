#! /bin/bash

# check for front-page.php file
if [ ! -f "front-page.php" ]; then
  echo "front-page.php file not found!"
  exit 1
fi

# from current folder, go to assets/fonts
cd assets/fonts

#find zip files
if ls *.zip 1> /dev/null 2>&1; then
  # Loop through the zip files and unzip them
  for zip_file in *.zip; do
    # Unzip the file into the same directory
    unzip "$zip_file"
  done
  rm *.zip
else
  echo "No zip files found in the directory."
fi

#find ttf files

if ls *.ttf 1> /dev/null 2>&1; then
  for file in *.ttf; do
    woff2_compress "$file"
    ttf2woff "$file" "${file%.*}.woff" 
  done
  # remove all .ttf files
  rm *.ttf
fi

for file in *.woff; do
  # Extract font name from the file name by removing the extension and any style information
  font_original="${file%.*}"
  font_name=$(echo "$font_original" | tr '[:upper:]' '[:lower:]')

  # # Initialize font-style and font-weight variables
  font_style="normal"
  font_weight="normal"

  # # Check if the font name contains "Italic" and set font-style accordingly
  if [[ $font_name == *"italic"* ]]; then
    font_style="italic"
  fi

  # Check for specific font weights and set font-weight accordingly
  if [[ $font_name == *"thin"* ]]; then
    font_weight="100"
  elif [[ $font_name == *"extralight"* ]]; then
    font_weight="200"
  elif [[ $font_name == *"light"* ]]; then
    font_weight="300"
  elif [[ $font_name == *"medium"* ]]; then
    font_weight="500"
  elif [[ $font_name == *"semibold"* || $font_name == *"demibold"* ]]; then
    font_weight="600"
  elif [[ $font_name == *"bold"* ]]; then
    font_weight="700"
  elif [[ $font_name == *"extrabold"* ]]; then
    font_weight="800"
  elif [[ $font_name == *"black"* || $font_name == *"heavy"* ]]; then
    font_weight="900"
  else
    font_weight="400"
  fi
  # echo "font_weight: $font_weight"
  font_name="${font_name%%-*}"  # Remove any style info
  capital_name="${font_name^}"

  # # Generate CSS rule with extracted font name, font-style, and font-weight
  echo "@font-face {
  font-family: '$capital_name'; 
  src: url('assets/fonts/${file%.*}.woff2') format('woff2'),
  url('assets/fonts/${file%.*}.woff') format('woff');
  font-weight: $font_weight;
  font-style: $font_style;
  font-display: swap;
}" >> ../../style.css
done

# go back to current folder
cd ../..
bat style.css
exit 0
