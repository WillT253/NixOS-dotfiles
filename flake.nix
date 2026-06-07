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
  };

  outputs =
    {
      self,
      nixpkgs,
      lazyvim,
      home-manager,
      plasma-manager,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      sysSettings = import ./sysSettings.nix;

    in
    {
      nixosConfigurations = {
        ${sysSettings.hostname} = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit sysSettings; };
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
                  inherit lazyvim plasma-manager sysSettings;
                };
              };
            }
          ];
        };
      };
    };
}
