#!/bin/bash
# https://docs.github.com/en/rest/reference/repos#get-a-release-asset
# GET /repos/{owner}/{repo}/releases/assets/{asset_id}

GITHUB_TOKEN="github_pat_...." # FILL ME IN
owner = ""
repo = ""

mkdir -p tmp

response_file=tmp/releases-latest.json
curl -sH "Authorization: Bearer ${GITHUB_TOKEN}" https://api.github.com/repos/${owner}/${repo}/releases/latest >${response_file}

read -r asset_id asset_name < <(jq -r '.assets[0] | "\(.id) \(.name)"' ${response_file})

pkill "${asset_name}"
rm -f "${asset_name}"

curl -L \
  -H "Accept: application/octet-stream" \
  -H "Authorization: Bearer ${GITHUB_TOKEN}" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "https://api.github.com/repos/${owner}/${repo}/releases/assets/${asset_id}" -o "${asset_name}"

chmod +x "${asset_name}"
rm -r tmp
