{
  config,
  lib,
  pkgs,
  ...
} @ args: let
  cfg = config.modules.home.gtk;
in {
  options.modules.home.gtk = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config =
    lib.mkIf cfg.enable {
      gtk = {
        enable = true;

        theme = {
          name = "Adwaita-dark";
          package = pkgs.gnome.gnome-themes-extra;
        };


        iconTheme = {
          name = "Adwaita";
          package = pkgs.gnome.adwaita-icon-theme;
        };

        cursorTheme = {
          name = "Adwaita";
          package = pkgs.gnome.adwaita-icon-theme;
        };
      };
    };
}
