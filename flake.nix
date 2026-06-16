{

  description = "Test flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    lazyvim.url = "github:pfassina/lazyvim-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    better-blur = {
      url = "github:xarblu/kwin-effects-better-blur-dx";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";

    sidra = {
      url = "github:wimpysworld/sidra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      lazyvim,
      home-manager,
      plasma-manager,
      better-blur,
      nixos-grub-themes,
      sidra,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      sysSettings = import ./sysSettings.nix;
      inherit inputs;
    in
    {
      nixosConfigurations = {
        ${sysSettings.hostname} = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit sysSettings nixos-grub-themes inputs; };
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${sysSettings.username} = import ./home-manager/home.nix;
                backupFileExtension = "backup";
                extraSpecialArgs = {
                  inherit
                    lazyvim
                    plasma-manager
                    sysSettings
                    better-blur
                    ;
                };
              };
            }
          ];
        };
      };
    };
}
