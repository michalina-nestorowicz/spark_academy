#!/usr/bin/bash

set -ou pipefail

TARGET_DIR="$1"

index=0
while true
do
    ts=$(date +"%Y-%m-%dT%H:%M:%S")
    echo "$ts" > "$TARGET_DIR/file.log.$index"
    sleep 5
    ((index++)) 
done
