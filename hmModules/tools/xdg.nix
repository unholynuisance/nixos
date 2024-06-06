{ config, lib, pkgs, ... }:
let cfg = config.nuisance.modules.hm.tools.xdg;
in {
  options = {
    nuisance.modules.hm.tools.xdg = { # #
      enable = lib.mkEnableOption "xdg";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ # #
      xdg-utils
      xdg-launch
    ];

    home.shellAliases = {
      open = "xdg-open";
      launch = "xdg-launch";
    };
  };
}
