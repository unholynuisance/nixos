{ config, lib, pkgs, ... }:
let cfg = config.nuisance.profiles.hm.games;
in {
  options.nuisance.profiles.hm.games = { # #
    enable = lib.mkEnableOption "games";
  };

  config = lib.mkIf cfg.enable {
    nuisance.modules.hm = {
      games = {
        minecraft = {
          enable = true;
          instances.gtnh.enable = true;
        };

        cataclysm-dda.enable = true;
      };
    };
  };
}
