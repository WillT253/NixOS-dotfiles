#!/usr/bin/env bash

set -o pipefail
export workingDir=$(pwd)

cd ~/.dotfiles

git add -A

sudo nixos-rebuild switch --flake .

cd $workingDir
