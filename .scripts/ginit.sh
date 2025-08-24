# ~/.scripts/initsub
#!/usr/bin/env bash
set -euo pipefail

# Usage: initsub <git-remote-url>
if [[ $# -ne 1 ]]; then
  echo "Usage: initsub git@…:user/repo.git" >&2
  exit 1
fi

remote=$1
repo_dir=${PWD##*/}
parent=$(git rev-parse --show-toplevel 2>/dev/null || dirname "$PWD")

# init & push this repo
git init
git branch -m main
git remote add origin "$remote"
touch README.md
git add README.md
git commit -m "Initial commit"
git push -u origin main

# go up and add as submodule
cd "$parent"
git submodule add "$remote" "$repo_dir"
git commit -m "Add submodule $repo_dir"
git push
