{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.modules.hm.games.starsector;
in
{
  options.nuisance.modules.hm.games.starsector = {
    enable = lib.mkEnableOption "starsector";
  };

  config = lib.mkIf cfg.enable { home.packages = with pkgs; [ starsector ]; };
}
