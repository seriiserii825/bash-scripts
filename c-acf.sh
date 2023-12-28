#!/bin/bash

file_path=~/Downloads/test/home.json

function generateId(){
  CHARACTER_SET="AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789"
  password=""
  for i in $(seq 1 13); do
    random_byte=$(od -An -N1 -i /dev/urandom)
    index=$((random_byte % ${#CHARACTER_SET}))
    password="${password}${CHARACTER_SET:index:1}"
  done
  return $password | tr -d '\n' | xsel -b -i 
}

function newTab(){
  name=$1
  echo $name
  slug=$(echo $name | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
  echo $slug
  result=$(cat $file_path | jq '.[0].fields[.[0].fields| length] += {
  "key": "field_333d8274aa9d6",
  "label": "'${name}'",
  "name": "'${slug}'",
  "aria-label": "",
  "type": "tab",
  "instructions": "",
  "required": 0,
  "conditional_logic": 0,
  "wrapper": {
  "width": "",
  "class": "",
  "id": ""
},
"placement": "top",
"endpoint": 0,
"date": "2010-01-07T19:55:99.999Z",
"xml": "xml_samplesheet_2017_01_07_run_09.xml",
"status": "OKKK",
"message": "metadata loaded into iRODS successfullyyyyy"
}')
echo $result > $file_path
}

# file_path=~/Downloads/test/home.json
# file_content=$(fzf)
# file_content=$(cat ~/Downloads/home.json)
# bat $file_content
# jq '.[] | .fields' $file_path

# result=$(cat $file_path | jq . += newTab 'Test')
newTab 'Test'
# echo $result
# jq '.[]'

# jq '.[0].fields[3]' $file_path

