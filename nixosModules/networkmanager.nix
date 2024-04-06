{ config, lib, pkgs, ... }:
let cfg = config.nuisance.modules.nixos.networkmanager;
in {
  options.nuisance.modules.nixos.networkmanager = {
    enable = lib.mkEnableOption "networkmanager";
  };

  config = lib.mkIf cfg.enable { networking.networkmanager.enable = true; };
}
