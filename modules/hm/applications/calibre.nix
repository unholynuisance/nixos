{ config, lib, pkgs, ... }@args:
let cfg = config.nuisance.modules.hm.applications.calibre;
in {
  options.nuisance.modules.hm.applications.calibre = {
    enable = lib.mkEnableOption "calibre";
  };

  config = lib.mkIf cfg.enable { home.packages = with pkgs; [ calibre ]; };
}
