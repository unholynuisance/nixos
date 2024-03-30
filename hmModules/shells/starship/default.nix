{ config, lib, pkgs, ... }:
let cfg = config.nuisance.modules.hm.shells.starship;
in {
  options.nuisance.modules.hm.shells.starship = {
    enable = lib.mkEnableOption "starship";
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = pkgs.lib.importTOML ./starship.toml;
    };
  };
}
