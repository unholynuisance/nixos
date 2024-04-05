{ config, lib, pkgs, self, self', inputs, inputs', ... }@args: {
  imports = [ inputs.wsl.nixosModules.wsl self.nixosModules.all ];

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
