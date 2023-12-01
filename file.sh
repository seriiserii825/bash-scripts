#! /bin/bash

file_path=$( fzf )
abs_path=$( realpath $file_path )
echo "File path is: $file_path"
COLUMNS=1
select action in Delete DeleteAllExceptThis Read CopyName CopyPath CopyAbsPath CopyToDownloads FileToBuffer BufferToFile Execute Get_Files_Size OpenInBrowser ToTemplatePart Quit; do
  case $action in
    Delete)
      rm $file_path
      echo "File $file_path was deleted"
      break
      ;;
    DeleteAllExceptThis)
      find -type f -not -name "$file" -delete
      echo "All files except $file were deleted"
      break
      ;;
    Read)
      bat $file_path
      ;;
    CopyName)
      echo $file_path | awk 'BEGIN{FS="/"}{print $NF}' | tr -d '\n' | xsel -b -i
      echo "File name was copied to clipboard"
      break
      ;;
    CopyPath)
      echo $file_path | tr -d '\n' | xsel -b -i
      echo "File path was copied to clipboard"
      break
      ;;
    CopyAbsPath)
      echo $abs_path | tr -d '\n' | xsel -b -i
      echo "File absolute path was copied to clipboard"
      break
      ;;
    CopyToDownloads)
      cp $file_path ~/Downloads
      break
      ;;
    Execute)
      chmod +x $file_path
      echo "Execute permission was added to $file_path"
      break
      ;;
    FileToBuffer)
      cat $file_path | tr -d '\n' | xsel -b -i
      echo "${tgreen}File was copied to clipboard${treset}"
      ;;
    BufferToFile)
      clipboard=$(xclip -o -selection clipboard)
      echo $clipboard > $file_path
      bat $file_path
      ;;
    Get_Files_Size)
      file * > files.txt
      awk -F "," '{print $1, $2}' files.txt
      rm files.txt
      ;;
    OpenInBrowser)
      google-chrome $file_path
      break
      ;;
    ToTemplatePart)
      filepath=$file_path
      filename=$(basename "$filepath")
      filename_no_ext="${filename%.*}"
      file_path_without_extension="${filepath%.*}"
      template_part="<?php echo get_template_part( '$file_path_without_extension'); ?>"
      echo $template_part | tr -d '\n' | xsel -b -i
      break
      ;;
    Quit)
      break
      ;;
    *)
      echo "ERROR! Please select between 1..3"
      ;;
  esac
done
