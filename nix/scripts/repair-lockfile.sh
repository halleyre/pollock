#!/usr/bin/env bash

set -o errexit
set -o pipefail

oldfile=$1
newfile=$2
json=$(cat $oldfile)

packages=$(jq -r '.packages
                  | keys[]
                  | select(startswith("node_modules/"))
                 ' <<< $json)
while IFS= read -r package; do
    export package
    
    IFS=| read resolved integrity link version <<< $(
      jq -r '.packages[env.package]
             | [.resolved, .integrity, .link, .version]
             | join("|")' <<< $json
    )

    if [[ "$resolved"  && ( "$integrity" || $link) ]]; then continue; fi

    package_name="${package##*node_modules/}"
    (
      response=$(curl -s "https://registry.npmjs.org/$package_name/$version")
      echo '{"package": "'$package'", "response": '$response'}' > $(mktemp webreqs.XXXXXXX)
    ) &
done <<< "$packages"

wait

for file in webreqs*; do
    export package=$(jq -r '.package' $file)
    response=$(jq -r '.response' $file)

    export resolved=$(jq -r '.dist.tarball' <<< $response)
    json=$(jq '.packages[env.package]
               .resolved = env.resolved' <<< $json)

    export integrity=$(echo "$response" | jq -r '.dist.integrity')
    json=$(jq '.packages[env.package]
               .integrity = env.integrity' <<< $json)

    rm $file
done

echo $json > $newfile
