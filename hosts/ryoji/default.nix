{inputs}:
with inputs; let
  lib = nixpkgs.lib;
in
  nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {};
    modules = [
      "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"

      home-manager.nixosModules.home-manager

      ./../../modules/nixos

      ({
        config,
        lib,
        ...
      }: {
        config = {
          networking.hostName = "ryoji";

          modules.nixos.guest.enable = true;
        };
      })
    ];
  }
