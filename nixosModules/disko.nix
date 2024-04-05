{ config, lib, pkgs, options, inputs, ... }:
let cfg = config.nuisance.modules.nixos.disko;
in {
  imports = [ # #
    inputs.disko.nixosModules.disko
  ];

  options.nuisance.modules.nixos.disko = {
    enable = lib.mkEnableOption "disko";
    config = options.disko;
  };

  config = lib.mkIf cfg.enable { # #
    disko = cfg.config;
  };
}
