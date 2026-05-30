#!/usr/bin/env bash

set -o pipefail
export dotsDir=~/nixos-dotfiles
export workingDir=$(pwd)

cd $dotsDir

sudo cp /etc/nixos/hardware-configuration.nix . # Ensure the correct hardware config is used by copying it from its original path on the system
echo "Copied 'hardware-configuration.nix' from /etc/nixos/"
$dotsDir/update-certs.sh # Update the certificate store
echo "Updated certificate store"

nh os switch path:. # The main event, now using nh so it looks prettier

cd $workingDir
