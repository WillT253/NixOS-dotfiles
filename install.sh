## Installation script for entire dotfiles

# TODO:
# Clone repo logic (steal the-one-and-only-fop)

## Setup

set -e

clear
echo "================================================================================================================================================================="
echo " _       __   _    __   __   ______   _                    _   __   _            ____     _____            ____              __     ____   _    __               "
echo "| |     / /  (_)  / /  / /  /_  __/  ( )  _____           / | / /  (_)  _  __   / __ \   / ___/           / __ \   ____     / /_   / __/  (_)  / /  ___     _____"
echo "| | /| / /  / /  / /  / /    / /     |/  / ___/          /  |/ /  / /  | |/_/  / / / /   \__ \           / / / /  / __ \   / __/  / /_   / /  / /  / _ \   / ___/" 
echo "| |/ |/ /  / /  / /  / /    / /         (__  )          / /|  /  / /  _>  <   / /_/ /   ___/ /          / /_/ /  / /_/ /  / /_   / __/  / /  / /  /  __/  (__  ) "
echo "|__/|__/  /_/  /_/  /_/    /_/         /____/          /_/ |_/  /_/  /_/|_|   \____/   /____/          /_____/   \____/   \__/  /_/    /_/  /_/   \___/  /____/  "
echo "================================================================================================================================================================="
echo ""

## Clone repo
echo "Cloning dotfiles repository to ~/nixos-dotfiles/ ..."
cd ~
git clone https://github.com/willt253/nixos-dotfiles
cd nixos-dotfiles

## Copy /etc/nixos/hardware-configuration.nix

sudo cp /etc/nixos/hardware-configuration.nix .

## Generate ./hwconfig-extra.nix

read -p "Do you want to add any extra hardware configuration? [y/N] " EXTRAHWCFG
EXTRAHWCFG=${EXTRAHWCFG:-n}
case "$EXTRAHWCFG" in
  [yY]|[yY][eE][sS] ) nano hwconfig-extra.nix;;
  [nN]|[nN][oO] )
cat << EOF > hwconfig-extra.nix
{
}
EOF
    ;;
  * ) exit 1;;
esac

## Run ./generate-sysSettings.sh

./generate-sysSettings.sh

## Ask about certs

echo "The next stage in the installation process will install any certificates you need."
echo "The certificates need to be in your '~/certs/' directory for this to happen."
echo "Please choose one of the following options to continue:"
echo
echo "    1. I have no certificates to install."
echo "    2. I Have certs to install and they are in the '~/certs/' directory."
echo "    3. Cancel / I need to move my certs to the proper directory"
echo
read -p "Choose an option (3): " INSTALLCERTS
INSTALLCERTS=${INSTALLCERTS:-"3"}
case "$INSTALLCERTS" in
  [12] ) ./update-certs.sh;;
  [3] ) exit 1;;
  * ) exit 1;;
esac

## Rebuild system

sudo nixos-rebuild boot --flake path:.#$__HOSTNAME --extra-experimental-features "nix-command flakes"
