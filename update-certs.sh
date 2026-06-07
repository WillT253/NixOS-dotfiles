#!/usr/bin/env bash
# Generates a Nix file containing a path list of certificates
CERT_DIR="$HOME/nixos-dotfiles/certs"
PERMANENT_CERT_DIR="$HOME/certs"
WORKING_DIR=$(pwd)

cd ~/nixos-dotfiles/

shopt -s nullglob

[ "$(ls -A certs)" ] && rm certs/*

for cert in "$PERMANENT_CERT_DIR"/*.pem "$PERMANENT_CERT_DIR"/*.crt; do
  cp $cert "$CERT_DIR"/
done

echo "[" > cert-list.nix
for cert in "$CERT_DIR"/*.pem; do
  echo "  ./certs/$(basename "$cert")" >> cert-list.nix
done
for cert in "$CERT_DIR"/*.crt; do
  echo "  ./certs/$(basename "$cert")" >> cert-list.nix
done
echo "]" >> cert-list.nix

cd $WORKING_DIR
