{ config, lib, pkgs, modulesPath, self, self', inputs, inputs', ... }: {
  imports = [ # #
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-gnome.nix"
    self.nixosModules.all
  ];

  config = {
    networking.hostName = "ryoji";

    nuisance.modules.nixos = { # #
      services = { # #
        ssh.enable = true;
      };

      virtualisation.guest.enable = true;
    };
  };
}
