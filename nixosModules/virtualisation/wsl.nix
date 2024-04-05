{ config, lib, pkgs, options, inputs, ... }:
let cfg = config.nuisance.modules.nixos.virtualisation.wsl;
in {
  imports = [ # #
    inputs.wsl.nixosModules.wsl
  ];

  options.nuisance.modules.nixos.virtualisation.wsl = {
    enable = lib.mkEnableOption "wsl";
    defaultUser = options.wsl.defaultUser;
  };

  config = lib.mkIf cfg.enable {
    wsl = {
      enable = true;

      defaultUser = cfg.defaultUser;
      startMenuLaunchers = true;

      wslConf = { # #
        automount.root = "/mnt";
      };
    };
  };
}
