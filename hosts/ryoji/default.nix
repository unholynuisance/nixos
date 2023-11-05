{
  config,
  lib,
  pkgs,
  modulesPath,
  self,
  home-manager,
  ...
} @ args: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
    home-manager.nixosModules.home-manager
    self.nixosModules.combined
  ];

  config = {
    networking.hostName = "ryoji";

    nuisance.modules.nixos = {
      guest.enable = true;
    };
  };
}
