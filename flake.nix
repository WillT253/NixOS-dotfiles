{

  description = "Test flake";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
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

    in
    {
      nixosConfigurations = {
        will-nixos = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.will = import ./home-manager/home.nix;
                backupFileExtension = "backup";
                extraSpecialArgs = {
                  inherit lazyvim plasma-manager;
                };
              };
            }
          ];
        };
      };
    };
}
