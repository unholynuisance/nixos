{ config, lib, pkgs, modulesPath, self, self', inputs, inputs', ... }@args: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
    inputs.home-manager.nixosModules.home-manager
    self.nixosModules.all
  ];

  config = {
    networking.hostName = "ryoji";

    nuisance.modules.nixos = { guest.enable = true; };
  };
}
