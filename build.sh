#!/usr/bin/env bash

API_URL=${API_URL:-"https:\/\/www.andrewflbarnes.com\/api"}

echo "Cleaning output folder: static"
rm -rf static

echo "Copying source files to output folder: src -> static"
cp -Rv src static

echo "Replacing placeholders"

for file in $(find static -name "*html" -o -name "*js")
do
  echo "Placeholder: API_URL -> $API_URL in $file"
  sed -i.delete '
    s/{{API_URL}}/'$API_URL'/g
  ' $file
done

echo "Deleting all modification backups"
find static -type f -name "*.delete" -exec rm -v {} +