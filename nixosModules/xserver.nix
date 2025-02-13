{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.nuisance.modules.nixos.xserver;
in
{
  options.nuisance.modules.nixos.xserver = {
    enable = lib.mkEnableOption "xserver";
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;

      xkb = {
        dir = "${pkgs.xkeyboard_config_patched}/etc/X11/xkb";
        layout = "us";
        variant = "";
      };
      excludePackages = with pkgs; [ xterm ];
    };

    environment.sessionVariables = {
      XKB_CONFIG_ROOT = config.services.xserver.xkb.dir;
    };
  };
}
