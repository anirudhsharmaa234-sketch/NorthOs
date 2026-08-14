#!/usr/bin/env bash
set -euo pipefail

SOURCE_URL='https://qkgxknpzydxwxzzttmsl.supabase.co/storage/v1/object/public/abel-frames/site/ABEL_CINEMATIC_PROD_SOURCE.zip'
SOURCE_SHA='8f24228d70fe83ddcdac7c282408d36112adc65683745aa16164ef359d1c9ce1'
ZIP='/tmp/abel-source.zip'

curl --fail-with-body --location --retry 4 --retry-all-errors "$SOURCE_URL" --output "$ZIP"
echo "$SOURCE_SHA  $ZIP" | sha256sum --check
unzip -oq "$ZIP" -d .

npm install --no-audit --no-fund
./node_modules/.bin/tsc -b
./node_modules/.bin/vite build

test -f dist/index.html
