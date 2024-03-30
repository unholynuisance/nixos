{ config, lib, pkgs, self, self', inputs, inputs', ... }@args: {
  imports = [
    inputs.wsl.nixosModules.wsl
    inputs.home-manager.nixosModules.home-manager
    self.nixosModules.nuisance
  ];

  config = {
    networking.hostName = "yui";

    wsl = {
      enable = true;
      defaultUser = "unholynuisance";
      startMenuLaunchers = true;
      wslConf = { # #
        automount.root = "/mnt";
      };
    };

    nuisance.modules.nixos = {
      shells.zsh.enable = true;

      users.unholynuisance = {
        enable = true;
        shell = pkgs.zsh;
        extraGroups = [ "wheel" ];
      };
    };
  };
}
