{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.modules.nixos.xkb;
  dir = "${pkgs.xkeyboard_config_patched}/etc/X11/xkb";
in
{
  options.nuisance.modules.nixos.xkb = {
    enable = lib.mkEnableOption "xkb";
  };

  config = lib.mkIf cfg.enable {
    environment.sessionVariables = {
      XKB_CONFIG_ROOT = dir;
    };

    services.xserver = {
      xkb = {
        inherit dir;
        layout = "us";
        variant = "";
      };
    };

  };
}
