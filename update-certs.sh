#!/usr/bin/env bash
# Generates a Nix file containing an absolute path list of your untracked certificates
CERT_DIR="$HOME/nixos-dotfiles/certs"

WORKING_DIR=$(pwd)

cd ~/nixos-dotfiles/

shopt -s nullglob

echo "[" > cert-list.nix
for cert in "$CERT_DIR"/*.pem; do
  echo "  ./certs/$(basename "$cert")" >> cert-list.nix
done
echo "]" >> cert-list.nix

cd $WORKING_DIR
