{ config, lib, pkgs, ... }@args:
let cfg = config.nuisance.modules.hm.gtk;
in {
  options.nuisance.modules.hm.gtk = { enable = lib.mkEnableOption "gtk"; };

  config = lib.mkIf cfg.enable {
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
