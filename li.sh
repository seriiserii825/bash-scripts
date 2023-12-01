#!/bin/bash
# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

filename=$1

# Check if the file exists
if [ ! -f "$filename" ]; then
    echo "File not found: $filename"
    exit 1
fi

# Loop through each line in the file and add <li> at the start and </li> at the end
new_file="new_file.txt"
if [ -f "$new_file" ]; then
    rm "$new_file"
fi
touch "$new_file"

echo "<ul>" >> "$new_file"
while IFS= read -r line; do
    echo "<li>${line}</li>" >> "$new_file"
done < "$filename"
echo "</ul>" >> "$new_file"

cat "$new_file" > "$filename"

