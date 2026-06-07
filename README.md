# WillT's NixOS dotfiles!

This repo contains all of my dotfiles for NixOS. This is currently deployed on two of my machines, one of them being my daily driver, and is under constant development. **This is a highly opinionated configuration, built specifically for me.** If you install this and encounter any issues, by all means create an issue. Any advice or suggestions on *new* features is welcomed, but changes to *currently installed* features is not, as these have been set up how I want them.

## Features

### DE - Plasma

I am using KDE Plasma as my DE as I am currently too busy/lazy to install and rice hyprland, but my intention is to switch when I can. I might bond with Plasma as I continue configuring it, and stay on it permanently, but my plan is to switch when I have the time to properly sit down and write some configs.

### WM - krohnkite

I tried Polonium; I didn't like it. I'm a very simple person, and my needs are not great: just some simple dynamic tiling with gaps. 

### Terminal - kitty/zsh

I like both, so I have both. Kitty provides the window theming, zsh provides the colors and layout. 

### Home-manager & plasma-manager

Essentials, now integrated into the system flake. Just run your favourite flavor of `nixos-rebuild` or `nh os`, or my handy update script, to rebuild the config.
NOTE: My configuration currently does NOT support hotswapping configs for Plasma. Any other programs are fine, but Plasma requires *at least* a re-log for changes to take effect.

### File-manager - `ranger`

A bit of an underdog when it comes to file managers, but the simplicity gives it a nice charm for me. I also picked it for the extensive use of `vi`-like keybinds.

### Browser - Qutebrowser

You'll come to realise very quickly that I'm a fan of `vi` keybinds.

### Xournal++

I use a graphics tablet to complete my work as printing is expensive and typing math is a pain (yes, I know LaTeX exists and I'm relatively well-versed in its syntax, but handwriting these things is often faster nonetheless).

### Easy Effects

S-tier. No notes.

### LibreOffice suite

Not used very often bit it is still useful to have at least a semi-comprehensive word processor for when handwritten notes are impractical.

### NeoVim (LazyVim)

I will work with **either** keyboard **or** mouse. Not both. TUIs are superior. NeoVim rules. 

### `nh`

This is self-explanatory. `nh` is just brilliant.

### Alias for updating config

After changing any configuration in the repo, just run `udnix` from any terminal managed by home-manager to rebuild the configuration.

### Probably more in the future!

## Installation

To be honest, I don't know what would possess someone to install this, but if you really want to, then install NixOS fresh or back up your existing configs first.

### 1. Clone the repo:
   ```bash
git clone https://github.com/willt253/nixos-dotfiles
   ```
Ensure this is in your home directory (`~/nixos-dotfiles`), or the symlinks will not work.

### 2. Copy `/etc/nixos/hardware-configuration.nix` into the repo in place of the file that will be cloned.
Unless you're on an HP Laptop 15-da0 series laptop that you've replaced several components of and whose drive just so happens to have exactly the same partition UUIDs as mine, you'll probably want to do this step or your config won't boot. You will only need to do this once: the file is under gitignore, so won't change with updates.

### 3. Set your desired hostname and username.
To do this, you must trawl through all of the configuration files in the repo, replacing 'will' with your desired *username* and 'will-nixos' with your desired *hostname*. You must repeat this step every time you pull from GitHub.
Did I say this would be simple?

### 4. Configure your certificates
This configuration is used on a system that requires CA certificates for a part of the workflow that I undergo, and the easiest way to have the certs integrate into my system was to include encrypted copies in the repository. However, this means you have to do more work if you are not me. First, delete the contents of the `certs/` directory, but keep the directory itself. At this point, if you have any certs of your own, **symlink or copy** them into the `certs/` directory (DO **NOT** *move* them: the pre-installed certs are `git`-tracked, so pulling the repo will replace the files). Then run `./update-certs.sh` to turn `cert-list.nix` into a valid (unencrypted) nix expression. If you have no certs to install, at this point you can remove the `certs/` directory without causing any harm. You must repeat all of this if you ever pull the changes from GitHub.

### 5. Rebuild your system using the prepared configs.
The first time you rebuild your system using these configs you will need to specify that you want to use the flake, and where the flake itself is. To rebuild your system run `sudo nixos-rebuild boot --flake path:.#your-HOSTNAME-here --extra-experimantal-features "nix-command flakes"`. Firstly, note that the flake is specified using `path:`; this is important as without it, the changes you made to other files in the cloned repo will not be recognised by the command and errors will occur. Also note the `your-HOSTNAME-here` afterwards. You know what to do with this part, I won't insult you. You only need to run this command once. See the next paragraph for what to do for subsequent updates.

**If you want to update your system after these steps have been completed**, for example if you want to install some of your own packages, I have provided a helper script with an alias: run `udnix` in bash, kitty or zsh, or `~/nixos-dotfiles/home-manager/udnix.sh` in any terminal to rebuild the system. This will also work in place of the rebuild step if you pull the latest changes from the repo, to save having to type out the huge command every time.

### 6. Reboot
Given that this is an entire system configuration, it is far safer to activate the new configuration on the next boot rather than in-place. Subsequent builds will have fewer changes, thuus the helper script rebuilds the system in-place. If there is a kernel update or otherwise major change to the system, I **strongly** recommend rebooting after updating.

### 7. Open an issue because this probably didn't work.

---

Good luck, my friend. You have chosen quite possibly the least stable NixOS configuration on this site.

Eventually I *might* make an autoinstall script for this mess, but for now you'll have to suffer.
I also *may* edit the directory structure to allow for you to add your own configs and not have them overwritten if/when you update the repo, but for now the steps above apply to pulling changes as well, and will destroy any edits you make.
