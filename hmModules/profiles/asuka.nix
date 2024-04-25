{ config, lib, pkgs, ... }:
let cfg = config.nuisance.profiles.hm.asuka;
in {
  options.nuisance.profiles.hm.asuka = { # #
    enable = lib.mkEnableOption "asuka";
  };

  config = lib.mkIf cfg.enable {
    nuisance.profiles.hm = {
      graphical.enable = true;
      games.enable = true;
    };
  };
}
