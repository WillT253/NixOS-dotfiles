#!/usr/bin/env bash

set -o pipefail
export dotsDir=~/nixos-dotfiles
export workingDir=$(pwd)

cd $dotsDir

git add -A # Ensure all files are at least staged in order for the rebuild command to recognise them
$dotsDir/update-certs.sh # Update the certificate store
sudo cp /etc/nixos/hardware-configuration.nix . # Ensure the correct hardware config is used by copying it from its original path on the system

sudo nixos-rebuild switch --flake . # The main event

cd $workingDir
