#!/usr/bin/env bash
# Generates a Nix file containing an absolute path list of your untracked certificates
CERT_DIR="~/nixos-dotfiles/certs"

WORKING_DIR=$(pwd)

cd ~/nixos-dotfiles/

echo "[" > cert-list.nix
for cert in "$CERT_DIR"/*.{crt,pem}; do
  if [ -f "$cert" ]; then
    echo "  \"$cert\"" >> cert-list.nix
  fi
done
echo "]" >> cert-list.nix

cd $WORKING_DIR
