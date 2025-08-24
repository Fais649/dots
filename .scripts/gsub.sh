#!/usr/bin/env bash
set -euo pipefail

# Usage: newsub <subdir> <git-remote-url>
subdir=$1
remote=$2
parent=$(git rev-parse --show-toplevel)

# create and push new repo
mkdir -p "$subdir"
cd "$subdir"
git init
git remote add origin "$remote"
touch README.md
git add README.md
git commit -m "Initial commit"
git push -u origin master

# go back and add as submodule
cd "$parent"
git submodule add "$remote" "$subdir"
git commit -m "Add submodule $subdir"
git push
