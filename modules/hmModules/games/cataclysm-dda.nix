{ config, lib, pkgs, ... }@args:
let cfg = config.nuisance.modules.hm.games.cataclysm-dda;
in {
  options.nuisance.modules.hm.games.cataclysm-dda = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config =
    lib.mkIf cfg.enable { home.packages = with pkgs; [ cataclysm-dda ]; };
}
