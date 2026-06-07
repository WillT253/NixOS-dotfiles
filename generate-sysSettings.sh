#!/usr/bin/env bash

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

# Detect or ask for Hostname
DEFAULT_HOSTNAME=$(hostname 2>/dev/null || echo "nixos-machine")
read -p "Enter your desired system hostname [$DEFAULT_HOSTNAME]: " HOSTNAME
HOSTNAME=${HOSTNAME:-$DEFAULT_HOSTNAME}

# Ask for full name
read -p "Enter your full name: " FULLNAME

# Detect or ask for Username
DEFAULT_USER=$USER
read -p "Enter your desired username [$DEFAULT_USER]: " USERNAME
USERNAME=${USERNAME:-$DEFAULT_USER}

# Detect or ask for Locale settings
DEFAULT_LOCALE="en_US"
read -p "Enter your desired keyboard layout [$DEFAULT_LOCALE]: " LOCALE
LOCALE=${LOCALE:-$DEFAULT_LOCALE}

# Detect or ask for Timezone
DEFAULT_TZ="America/New_York"
if [ -f /etc/timezone ]; then
    DEFAULT_TZ=$(cat /etc/timezone)
elif command -v timedatectl >/dev/null 2>&1; then
    DEFAULT_TZ=$(timedatectl | grep "Time zone" | awk '{print $3}')
fi
read -p "Enter your timezone [$DEFAULT_TZ]: " TIMEZONE
TIMEZONE=${TIMEZONE:-$DEFAULT_TZ}

echo ""
echo "════════════════════════════════════════════"
echo "      Generating sysSettings.nix with:      "
echo "        Hostname:  $HOSTNAME                "
echo "        Username:  $USERNAME                "
echo "        Full name: $FULLNAME                "
echo "        Locale:    $LOCALE                  "
echo "        Timezone:  $TIMEZONE                "
echo "════════════════════════════════════════════"
echo ""
read -p "Continue? [Y/n] " CONFIRMATION
CONFIRMATION=${CONFIRMATION:-y}
case "$CONFIRMATION" in
  [yY]|[yY][eE][sS] )

    # Generate the local-settings.nix file
    cat << EOF > sysSettings.nix
{
  hostname = "${HOSTNAME}";
  username = "${USERNAME}";
  fullname = "${FULLNAME}";
  locale = "${LOCALE}";
  timezone = "${TIMEZONE}";
}
EOF
    ;;

  [nN]|[nN][oO] ) exit 1;;
  * ) exit 1;;
esac
