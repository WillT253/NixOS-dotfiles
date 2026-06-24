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

### Browser - Firefox

I use the Vimium extension to add `vi` keybinds to the browser. I'm looking at a few options at the moment and Zen may be on the horizon once I look into it fully.

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

### `rg` and `fd`

If you haven't heard of them, RipGrep (`rg`) and `fd` are extremely powerful replacements for the `grep` and `find` tools. They are blazingly fast in comparison to their built-in counterparts and have far more options when it comes to actually finding things.

### croc

I need to send files between my machines. Croc is a great way to do that.

### jrnl

I like being able to just write, and jrnl allows me to do that in one command. I may switch to a simple directory that I add notes to with NeoVim, but for now, jrnl is proving very useful.

### Alias for updating config

After changing any configuration in the repo, just run `udnix` from any terminal managed by home-manager to rebuild the configuration.

### Probably more in the future!

## Installation

To be honest, I don't know what would possess someone to install this, but if you really want to, then install NixOS fresh or back up your existing configs first. Note that this section only applies to first-time installation; see (§ Updating the configuration) for how to update.

### 1. Clone the repo:

   ```bash
git clone https://github.com/willt253/nixos-dotfiles
   ```
Ensure this is in your home directory (`~/nixos-dotfiles`), or the symlinks will not work.

### 2. Set up hardware configuration.

Unless you're on an HP Laptop 15-da0 series laptop that you've replaced several components of and whose drive just so happens to have exactly the same partition UUIDs as mine, you'll probably want to do this step or your config won't boot.
Copy `/etc/nixos/hardware-configuration.nix` into the repo. Next, create a new file, `hwconfig-extra.nix`. If you have any extra hardware configurations, they should go in this file. If you don't have any extra configuration to add or don't want to mess with any hardware config, just add the following to the file:
```nix
{
}
```

### 3. Set some basic settings.

Run `./generate-sysSettings.sh` to generate basic settings such as locale, keyboard layout, etc.

### 4. Configure your certificates

This configuration is used on a system that requires CA certificates for a part of the workflow that I undergo, and the easiest way to have the certs integrate into my system was to include encrypted copies in the repository. However, these will be no good to you, so you need to set up your own certs. To do this, place all of your certificates in `~/certs/` (skip this if you don't need to add any certs) and then run `./update-certs.sh` to turn `cert-list.nix` into a valid nix expression.

### 5. Rebuild your system using the prepared configs.

The first time you rebuild your system using these configs you will need to specify that you want to use the flake, and where the flake itself is. To rebuild your system run `sudo nixos-rebuild boot --flake path:.#your-HOSTNAME-here --extra-experimantal-features "nix-command flakes"`. Firstly, note that the flake is specified using `path:`; this is important as without it, the changes you made to other files in the cloned repo will not be recognised by the command and errors will occur. Also note the `your-HOSTNAME-here` afterwards. You know what to do with this part, I won't insult you.

### 6. Reboot

Given that this is an entire system configuration, it is far safer to activate the new configuration on the next boot rather than in-place. Subsequent builds will have fewer changes, thus the helper script rebuilds the system in-place. If there is a kernel update or otherwise major change to the system, I **strongly** recommend rebooting after updating.

### 7. Open an issue because this probably didn't work.

## Updating the configuration

Once you have installed this mess, the consolation is that updating it is *slightly* easier than installing it was. There are two options for updating, depending on what you want to achieve.

### 1. Updating while keeping your edits

For now, if you edit your configuration, pulling any changes from github will either overwrite your changes or cause merge conflicts on your local clone. The safest option is you don't want to deal with all of this is to simply run `udnix` from zsh, bash or kitty, or `~/nixos-dotfiles/home-manager/udnix.sh` from any other terminal. If you have enabled configuration for any other terminals in `home.nix`, the alias will be automatically applied for ease of access. Note that this will not update your system to the latest version hosted here, but rather only apply changes you make locally.

### 2. Updating to the latest version from github

If you haven't edited your configuration, or are happy to resolve any conflicts that may occur when you pull, `cd` into the repo and ensure all of your changes have been committed or stashed, then run `git pull --rebase origin main` to grab the latest changes. If merge conflicts occur, edit the affected files (run `git status` to see which files are affected), add them to the staging area with `git add <filename>`, and finally run `git rebase --contine` when all conflicts have been resolved.

---

Good luck, my friend. You have chosen quite possibly the least stable NixOS configuration on this site.

Eventually I *might* make an autoinstall script for this mess, but for now you'll have to suffer.
I also *may* edit the directory structure to allow for you to add your own configs and not have them overwritten if/when you update the repo, but for now you'll have to do this manually. If you want to help out, PRs are welcomed, though I reserve the right to the final say in whether your code makes it into the repo.
