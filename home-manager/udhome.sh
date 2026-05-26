#!/usr/bin/env bash

set -o pipefail
export originalDir=$(pwd)

cd ~/nixos-dotfiles
git add -A
home-manager switch --flake .

cd $originalDir
