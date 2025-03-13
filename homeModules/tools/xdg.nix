{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.modules.hm.tools.xdg;
in
{
  options = {
    nuisance.modules.hm.tools.xdg = {
      enable = lib.mkEnableOption "xdg";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      xdg-utils

      # xdg-launch without .desktop files
      (xdg-launch.overrideAttrs (_: {
        postInstall = ''
          rm -r $out/share/applications
          rm -r $out/etc/xdg/autostart
        '';
      }))
    ];

    home.shellAliases = {
      open = "xdg-open";
      launch = "xdg-launch";
    };
  };
}
