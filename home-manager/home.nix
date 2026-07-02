{
  pkgs,
  lazyvim,
  config,
  plasma-manager,
  sysSettings,
  better-blur,
  ...
}:

{
  imports = [
    lazyvim.homeManagerModules.default
    plasma-manager.homeModules.plasma-manager
  ];

  fonts.fontconfig.enable = true;

  home = {
    packages = with pkgs; [
      statix
      nil
      nixfmt
      better-blur.packages.${pkgs.system}.default
    ];

    file.".config/autostart/goToDesktopOne.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Reset Virtual Desktop
      Comment=Force Plasma to open Virtual Desktop 1 on login
      Exec=${pkgs.kdotool}/bin/kdotool set_desktop 1
      X-KDE-Autostart-phase=2
    '';

    shellAliases = {
      "la" = "ls -al";
      "ls-ext" = "ls -Abhlps";
      "udnix" = "~/nixos-dotfiles/home-manager/udnix.sh";
      "nixcln" = "~/nixos-dotfiles/home-manager/nixcln.sh";
      ":q" = "exit";
      "gpl" = "git pull";
      "gs" = "git status";
      "gbls" = "git branch --list";
      ":wq" = "exit";
      "gre" = "git restore";
      "ecfg" = "cd ~/nixos-dotfiles/; nvim .";
      "grep" = "rg";
      "find" = "fd";
      "ssuuddoo" = "sudo -i";
    };

    username = "${sysSettings.username}";
    homeDirectory = "/home/${sysSettings.username}";

    stateVersion = "26.05";
  };

  xdg.configFile = {
    "kitty/kitty.conf".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/home-manager/kitty.conf";
    "kitty/current-theme.conf".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/home-manager/kitty-current-theme.conf";
    "kitty/quick_access_terminal.conf".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/home-manager/quick_access_terminal.conf";
    "kwinrc".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/home-manager/kwinrc";
    "home-manager".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/home-manager";
    "nyxt".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/home-manager/nyxt";
    "kwinrulesrc".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/home-manager/kwinrulesrc";
    "fastfetch/config.jsonc".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/home-manager/fastfetch-config.jsonc";
  };

  programs = {
    bash = {
      enable = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history = {
        append = true;
      };
      initContent = pkgs.lib.mkOrder 1000 ''
        # Open buffer line in editor
        autoload -Uz edit-command-line
        zle -N edit-command-line
        bindkey '^x^e' edit-command-line

        bindkey -s '^Xgc' 'gc -m ""\C-b'

        bindkey -s '^Xga' 'ga -A'

        fastfetch
      '';
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
        ];
        theme = "gallifrey";
      };
    };

    lazyvim = {
      enable = true;
      extras.lang.nix.enable = true;
    };

    plasma = {
      configFile = {
        "kwinrc" = {
          "Plugins" = {
            "better_blur_dxEnabled" = true;
            "blurEnabled" = false;
            "backgroundcontrastEnabled" = false;
          };
          "Effect-better-blur-dx" = {
            "BlurMatching" = false;
            "BlurNonMatching" = true;
            "BlurStrength" = 8;
            "NoiseStrength" = 2;
            "WindowClasses" = ".*";
          };
        };
      };

      krunner = {
        position = "center";
        shortcuts.launch = "Meta+X";
      };

      hotkeys.commands = {
        launch-browser = {
          name = "Launch Browser";
          key = "Meta+B";
          command = "firefox";
        };
        launch-konsole = {
          name = "Launch Konsole";
          key = "Meta+Return";
          command = "kitty";
        };
        file-manager = {
          name = "Launch File Manager";
          key = "Meta+E";
          command = "kitty ranger";
        };
      };

      enable = true;

      session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

      overrideConfig = false;

      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
        wallpaper = ./wallpapers/femWPAce.png;
      };

      input = {
        keyboard = {
          numlockOnStartup = "on";
          switchingPolicy = "global";
        };

        touchpads = [
          {
            disableWhileTyping = true;
            enable = true;
            middleButtonEmulation = true;
            naturalScroll = true;
            scrollMethod = "touchPadEdges";
            vendorId = "0002";
            productId = "0007";
            name = "SynPS/2 Synaptics TouchPad";
          }
        ];
      };
      panels = [
        {
          location = "right";
          height = 44;
          floating = true;
          lengthMode = "fill";
          hiding = "autohide";
          opacity = "translucent";
          widgets = [
            "org.kde.plasma.kickoff"
            "org.kde.plasma.panelspacer"
            "org.kde.plasma.marginsseparator"
            "org.kde.plasma.digitalclock"
            "org.kde.plasma.systemtray"
            "org.kde.plasma.pager"
          ];
        }
        {
          location = "top";
          height = 320;
          floating = true;
          lengthMode = "fit";
          hiding = "autohide";
          opacity = "translucent";
          widgets = [
            "org.kde.plasma.mediacontroller"
          ];
        }
      ];
      kwin = {
        virtualDesktops = {
          names = [
            "Terminal"
            "Browser"
            "Reference"
            "Workspace"
            "Files"
            "Music"
            "Messaging"
            "Art"
            "Photos"
          ];
          rows = 3;
        };

        scripts = {
          polonium = {
            enable = false;
            settings.borderVisibility = "borderAll";
          };
        };

        effects = {
          desktopSwitching.navigationWrapping = true;
          dimAdminMode.enable = true;
        };
      };

      shortcuts = {
        # "services/org.kde.dolphin.desktop"."_launch" = "none";
        kwin = {
          "Switch to Next Desktop" = "Meta+Space";
          "Switch to Previous Desktop" = "Meta+Alt+Space";
          "Switch One Desktop Down" = "Meta+Ctrl+Space";
          "Switch One Desktop Up" = "Meta+Ctrl+Alt+Space";
          "Window to Next Desktop" = "Meta+Shift+Space";
          "Window to Previous Desktop" = "Meta+Alt+Shift+Space";
          "Window One Desktop Down" = "Meta+Ctrl+Shift+Space";
          "Window One Desktop Up" = "Meta+Ctrl+Alt+Shift+Space";
          "Window Close" = "Meta+Q";
          "Switch to Desktop 1" = "Meta+1";
          "Switch to Desktop 2" = "Meta+2";
          "Switch to Desktop 3" = "Meta+3";
          "Switch to Desktop 4" = "Meta+4";
          "Switch to Desktop 5" = "Meta+5";
          "Switch to Desktop 6" = "Meta+6";
          "Switch to Desktop 7" = "Meta+7";
          "Switch to Desktop 8" = "Meta+8";
          "Switch to Desktop 9" = "Meta+9";
          "Window to Desktop 1" = "Meta+Shift+1";
          "Window to Desktop 2" = "Meta+Shift+2";
          "Window to Desktop 3" = "Meta+Shift+3";
          "Window to Desktop 4" = "Meta+Shift+4";
          "Window to Desktop 5" = "Meta+Shift+5";
          "Window to Desktop 6" = "Meta+Shift+6";
          "Window to Desktop 7" = "Meta+Shift+7";
          "Window to Desktop 8" = "Meta+Shift+8";
          "Window to Desktop 9" = "Meta+Shift+9";
        };
        org_kde_powerdevil = {
          "powerProfile" = "none";
        };
        plasmashell = {
          "cycle-panels" = "Meta+Z";
          "activate task manager entry 1" = "none";
          "activate task manager entry 2" = "none";
          "activate task manager entry 3" = "none";
          "activate task manager entry 4" = "none";
          "activate task manager entry 5" = "none";
          "activate task manager entry 6" = "none";
          "activate task manager entry 7" = "none";
          "activate task manager entry 8" = "none";
          "activate task manager entry 9" = "none";
        };
      };
    };
    konsole = {
      enable = true;
      profiles."${sysSettings.username}" = {
        command = "${pkgs.kitty}/bin/kitty";
        extraConfig = {
          Appearance = {
            Font = "CaskaydiaCove Nerd Font Mono,16";
            ASCIICharacters = true;
            EnableComplexTextLayout = true;
            CharacterSpacing = 1;
            WordMode = false;
            FontFeatures = "calt,liga";
          };
        };
      };
      defaultProfile = "${sysSettings.username}";
    };
  };
}
