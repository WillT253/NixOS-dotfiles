{

  description = "Test flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    lazyvim.url = "github:pfassina/lazyvim-nix";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
          ];
        };
      };

      homeConfigurations = {
        will = home-manager.lib.homeconfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit lazyvim; };
          modules = [
            /home/will/.config/home-manager/home.nix
            plasma-manager.homeModules.plasma-manager
          ];
        };
      };

    };

}
