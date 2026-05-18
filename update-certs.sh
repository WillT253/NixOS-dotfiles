#!/usr/bin/env bash
# Generates a Nix file containing an absolute path list of your untracked certificates
CERT_DIR="/home/will/.dotfiles/certs"

echo "[" > cert-list.nix
for cert in "$CERT_DIR"/*.{crt,pem}; do
  if [ -f "$cert" ]; then
    echo "  \"$cert\"" >> cert-list.nix
  fi
done
echo "]" >> cert-list.nix
