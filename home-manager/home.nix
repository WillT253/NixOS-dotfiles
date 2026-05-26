# home.nix

{
  pkgs,
  lazyvim,
  config,
  ...
}:
{
  imports = [
    lazyvim.homeManagerModules.default
  ];

  fonts.fontconfig.enable = true;

  home = {
    packages = with pkgs; [
      hello
      statix
      nil
      nixfmt-rfc-style
    ];

    shellAliases = {
      "la" = "ls -al";
      "udnix" = "~/nixos-dotfiles/home-manager/udnix.sh";
      "udhome" = "~/nixos-dotfiles/home-manager/udhome.sh";
      "nixcln" = "~/nixos-dotfiles/home-manager/nixcln.sh";
      ":q" = "exit";
      "gpl" = "git pull";
    };

    username = "will";
    homeDirectory = "/home/will";

    stateVersion = "25.11";
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
      krunner = {
        position = "center";
        shortcuts.launch = "Meta+X";
      };

      hotkeys.commands = {
        launch-browser = {
          name = "Launch Firefox";
          key = "Meta+B";
          command = "firefox";
        };
        launch-konsole = {
          name = "Launch Konsole";
          key = "Meta+Return";
          command = "kitty";
        };
      };

      enable = true;

      session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

      overrideConfig = false;

      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
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
          hiding = "none";
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

        tiling.padding = 36;
      };

      configFile = {
        #"kwinrc" = {
        #  "org.kde.polonium" = {
        #   "gapsInner" = 36;
        #   "gapsOuter" = 36;
        # };

        # "Plugins"."krohnkiteEnabled" = "true";
        # "krohnkite"."gapInner" = "10";
        #};

        "yakuakerc"."Behavior"."FocusOnStart" = false;
      };

      window-rules = [
        {
          description = "Maximize by default";
          match.window-types = [ "normal" ];
          apply = {
            maximizedhoriz = {
              value = true;
              apply = "initially";
            };
            maxinizedvert = {
              value = true;
              apply = "initially";
            };
          };
        }
      ];

      shortcuts = {
        kwin = {
          "Switch to Next Desktop" = "Meta+Space";
          "Switch to Previous Desktop" = "Meta+Alt+Space";
          "Switch One Desktop Down" = "Meta+Ctrl+Space";
          "Switch One Desktop Up" = "Meta+Ctrl+Alt+Space";
          "Window to Next Desktop" = "Meta+Shift+Space";
          "Window to Previous Desktop" = "Meta+Alt+Shift+Space";
          "Window One Desktop Down" = "Meta+Ctrl+Shift+Space";
          "Window One Desktop Up" = "Meta+Ctrl+Alt+Shift+Space";
        };
        org_kde_powerdevil = {
          "powerProfile" = "none";
        };
      };
    };
    konsole = {
      enable = true;
      profiles."will" = {
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
      defaultProfile = "will";
    };
  };
}
