{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.profiles.hm.rei;
in
{
  options.nuisance.profiles.hm.rei = {
    enable = lib.mkEnableOption "rei";
  };

  config = lib.mkIf cfg.enable {
    nuisance.profiles.hm = {
      cli.enable = true;
      graphical.enable = true;
      games.enable = true;
    };
  };
}
