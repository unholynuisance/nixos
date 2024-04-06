{ config, lib, pkgs, self, self', inputs, inputs', ... }: {
  imports = [ # #
    self.nixosModules.all
  ];

  config = {
    networking.hostName = "yui";

    nuisance.modules.nixos = {
      shells.zsh.enable = true;

      virtualisation.wsl = {
        enable = true;
        defaultUser = "unholynuisance";
      };

      users.unholynuisance = {
        enable = true;
        shell = pkgs.zsh;
        extraGroups = [ "wheel" ];
      };
    };
  };
}
