#!/usr/bin/env bash

set -o pipefail
export originalDir=$(pwd)

cd ~/.config/home-manager
git add -A
make update

cd $originalDir
