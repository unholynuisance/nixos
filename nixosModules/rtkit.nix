{ config, lib, pkgs, ... }@args:
let cfg = config.nuisance.modules.nixos.rtkit;
in {
  options.nuisance.modules.nixos.rtkit = {
    enable = lib.mkEnableOption "rtkit";
  };

  config = lib.mkIf cfg.enable { security.rtkit.enable = true; };
}
