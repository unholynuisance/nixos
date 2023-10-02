{
  config,
  lib,
  pkgs,
  modulesPath,
  nixosModules,
  home-manager,
  ...
} @ args: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
    home-manager.nixosModules.home-manager
    nixosModules
  ];

  config = {
    networking.hostName = "ryoji";

    modules.nixos.guest.enable = true;
  };
}
