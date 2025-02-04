{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.profiles.hm.kaworu;
in
{
  options.nuisance.profiles.hm.kaworu = {

    enable = lib.mkEnableOption "kaworu";
  };

  config = lib.mkIf cfg.enable {
    nuisance.profiles.hm = {
      cli.enable = true;
      graphical.enable = true;
    };
  };
}
