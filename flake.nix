{
  description = "A very basic flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixpkgs-master = {
      url = "github:nixos/nixpkgs/master";
    };

    nixpkgs-release = {
      url = "github:nixos/nixpkgs/nixos-25.05";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xkeyboard-config-src = {
      url = "github:unholynuisance/xkeyboard-config";
      flake = false;
    };

    doom-emacs = {
      url = "github:unholynuisance/.doom.d";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.devenv.follows = "devenv";
      inputs.treefmt-nix.follows = "treefmt-nix";
    };

    xwayland-global-shortcut-bridge = {
      url = "github:unholynuisance/xwayland-global-shortcut-bridge";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.devenv.follows = "devenv";
      inputs.treefmt-nix.follows = "treefmt-nix";
    };
  };

  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./nix/modules/flake
      ];
    };
}
