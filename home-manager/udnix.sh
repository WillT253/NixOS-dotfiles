#!/usr/bin/env bash

set -o pipefail
export dotsDir=~/nixos-dotfiles
export workingDir=$(pwd)

cd $dotsDir

sudo cp /etc/nixos/hardware-configuration.nix . # Ensure the correct hardware config is used by copying it from its original path on the system
echo "Copied 'hardware-configuration.nix' from /etc/nixos/ ..."
$dotsDir/update-certs.sh # Update the certificate store
echo "Updated certificate store ..."
git add -A # Ensure all files are at least staged in order for the rebuild command to recognise them
echo "Staged changed files to git ..."

echo -e "\033[0;33mYou may be prompted for your sudo password at the end of the next step.\033[0m"
nh os switch . # The main event, now using nh so it looks prettier

cd $workingDir
