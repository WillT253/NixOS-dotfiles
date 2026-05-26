# WillT's NixOS dotfiles!

This repo contains all of my dotfiles for NixOS. This is currently deployed on two of my machines, one of them being my daily driver, and is under constant development. **This is a highly opinionated configuration, built specifically for me.** If you install this and encounter any issues, by all means create an issue. Any advice or suggestiond on *new* features is welcomed, but changes to *currently installed* features is not, as these have been set up how I want them.

## Features

### DE - Plasma

I am using KDE Plasma as my DE as I am currently too busy/lazy to install and rice hyprland, but my intention is to switch when I can. I might bond with Plasma as I continue configuring it, and stay on it permanently, but my plan is to switch when I have the time to properly sit down and write some configs.

### WM - krohnkite

I tried Polonium; I didn't like it. I'm a very simple person, and my needs are not great: just some simple dynamic tiling with gaps. 

### Terminal - kitty/zsh

I like both, so I have both. Kitty provides the window theming, zsh provides the colors and layout. 

### Xournal++

I use a graphics tablet to complete my work as printing is expensive and typing math is a pain (yes, I know LaTeX exists and I'm relatively well-versed in its syntax, but handwriting these things is often faster nonetheless).

### Easy Effects

S-tier. No notes.

### LibreOffice suite

Not used very often bit it is still useful to have at least a semi-comprehensive word processor for when handwritten notes are impractical.

### NeoVim (LazyVim)

I will work with **either** keyboard **or** mouse. Not both. TUIs are superior. NeoVim rules. 

### Probably more in future!

## Installation

To be honest, I don't know what would possess someone to install this, but if you really want to, then install NixOS fresh or back up your existing configs first.

### 1. Clone the repo:
   ```bash
git clone https://github.com/willt253/nixos-dotfiles
   ```
Ensure this is in your home directory (`~/nixos-dotfiles`), or the symlinks will not work.

### 2. Meticulously trawl through all of the configuration files and replace 'will' with your desired username, and 'will-nixos' with your desired hostname.

Did I say this would be simple?

### 3. Back up or remove all of the files referenced in `home-manager/home.nix`'s `mkOutOfStoreSymlink` blocks, as they will cause errors if not.

### 4. Remove the contents of the `certs/` directory, and run `./update-certs.sh`

### 5. Run `sudo nixos-rebuild switch --flake path:~/nixos-dotfiles/#your-hostname-here`, replacing `your-hostname-here` with the hostname you chose for your system and replaced 'will-nixos' with in `configuration.nix`

### 6. Reboot

### 7. Open a terminal in the `~/nixos-dotfiles/home-manager` directory and run `home-manager switch --flake path:.#your-username-here`, replacing `your-username-here` with your chosen username.

### 8. Either log out and back in again or reboot your system.

### 9. Open an issue because this probably didn't work.

---

Good luck, my friend. You have chosen quite possibly the least stable NixOS configuration on this site.
