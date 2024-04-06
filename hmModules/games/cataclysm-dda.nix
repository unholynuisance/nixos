{ config, lib, pkgs, ... }:
let cfg = config.nuisance.modules.hm.games.cataclysm-dda;
in {
  options.nuisance.modules.hm.games.cataclysm-dda = {
    enable = lib.mkEnableOption "cataclysm-dda";
  };

  config =
    lib.mkIf cfg.enable { home.packages = with pkgs; [ cataclysm-dda ]; };
}
