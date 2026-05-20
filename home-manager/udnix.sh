#!/usr/bin/env bash

set -o pipefail
export dotsDir=~/nixos-dotfiles
export workingDir=$(pwd)

cd $dotsDir

git add -A
$dotsDir/update-certs.sh

sudo nixos-rebuild switch --flake path:.

cd $workingDir
