{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.profiles.hm.yui;
in
{
  options.nuisance.profiles.hm.yui = {

    enable = lib.mkEnableOption "yui";
  };

  config = lib.mkIf cfg.enable {
    nuisance.profiles.hm = {
      cli.enable = true;
      graphical.enable = true;
    };
  };
}
