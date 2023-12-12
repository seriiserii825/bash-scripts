#! /bin/bash -x

function ttfToWoff2() {
  if ls *.ttf 1> /dev/null 2>&1; then
    for file in *.ttf; do
      woff2_compress "$file"
      ttf2woff "$file" "${file%.*}.woff" 
    done
    rm *.ttf
  else
    echo "${tmagenta}no ttf files found${treset}"
  fi
}

function woffToCss(){
  if ls *.woff 1> /dev/null 2>&1; then
    touch fonts.css
    for file in *.woff; do
      # Extract font name from the file name by removing the extension and any style information
      font_original="${file%.*}"
      font_name=$(echo "$font_original" | tr '[:upper:]' '[:lower:]')

      font_style="normal"
      font_weight="normal"

      if [[ $font_name == *"italic"* ]]; then
        font_style="italic"
      fi

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

      echo "@font-face {
      font-family: '$capital_name'; 
      src: url('assets/fonts/${file%.*}.woff2') format('woff2'),
      url('assets/fonts/${file%.*}.woff') format('woff');
      font-weight: $font_weight;
      font-style: $font_style;
      font-display: swap;
      }" >> fonts.css
    done
    bat fonts.css
    cat fonts.css | xclip -selection clipboard
    rm fonts.css
  else
    echo "${tmagenta}no woff files found${treset}"
  fi
}

select action in info convert
do
  case $action in
    info)
      echo "${tgreen}Add to current directory ttf or woff and woff2 files${treset}"
      echo "${tblue}This script will convert them to woff2 and woff and generate css file${treset}"
      echo "${tyellow}css file will be copied to clipboard${treset}"
      break
      ;;
    convert)
      ttfToWoff2
      woffToCss
      break
      ;;
    *)
      echo "${tmagenta}invalid option${treset}"
      ;;
  esac
done


