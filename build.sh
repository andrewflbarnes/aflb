#!/usr/bin/env bash

API_URL=${API_URL:-"https://api.andrewflbarnes.com"}
CDN_URL=${CDN_URL:-"https://aflbcdn.com"}

# modifies "/" characters to prevent sed misinterpretation
SED_API_URL=$(sed 's/\//\\\//g' <<< $API_URL)
SED_CDN_URL=$(sed 's/\//\\\//g' <<< $CDN_URL)

echo "Cleaning output folder: static"
rm -rf static

echo "Copying source files to output folder: src -> static"
cp -Rv src static

echo "Replacing placeholders"
echo "- API_URL -> $API_URL"
echo "- CDN_URL -> $CDN_URL"
for file in $(find static -name "*html" -o -name "*js")
do
  echo "Replacing placeholders in file $file"
  sed -i.delete '
    s/{{API_URL}}/'$SED_API_URL'/g
    s/{{CDN_URL}}/'$SED_CDN_URL'/g
  ' $file
done

echo "Deleting all modification backups"
find static -type f -name "*.delete" -exec rm -v {} +