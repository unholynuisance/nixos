{ config, lib, pkgs, ... }@args:
let cfg = config.nuisance.modules.hm.applications.zotero;
in {
  options.nuisance.modules.hm.applications.zotero = {
    enable = lib.mkEnableOption "zotero";
  };

  config = lib.mkIf cfg.enable { home.packages = with pkgs; [ zotero ]; };
}
