#!/usr/bin/env bash
set -euo pipefail

# push current repo
git push

# climb up, update submodule ref, commit & push each parent
dir=$(pwd)
while [[ -d "$dir/.."/.git || -f "$dir/.git" ]]; do
  parent=$(dirname "$dir")
  cd "$parent"
  # update this submodule pointer
  git add "${dir##*/}"
  git diff --staged --quiet || {
    git commit -m "Update submodule $(basename "$dir") to latest"
    git push
  }
  dir=$parent
done
