# flake.nix

{
  description = "Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    lazyvim.url = "github:pfassina/lazyvim-nix";
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      plasma-manager,
      lazyvim,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

    in
    {
      homeConfigurations = {
        will = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit (inputs) lazyvim; };
          modules = [
            ./home.nix
            inputs.plasma-manager.homeModules.plasma-manager
          ];
        };
      };
    };
}
