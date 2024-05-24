{ config, lib, pkgs, ... }:
let cfg = config.nuisance.profiles.hm.gnome;
in {
  options.nuisance.profiles.hm.gnome = { # #
    enable = lib.mkEnableOption "gnome";
  };

  config = lib.mkIf cfg.enable { # #
    nuisance.modules.hm = {
      gnome = {
        enable = true;

        extensions = with pkgs.gnomeExtensions; [
          appindicator
          ip-finder
          freon
        ];

        favouriteApps = [ # #
          "firefox"
          "org.gnome.Console"
          "emacs"
          "org.gnome.Nautilus"
        ];

        appFolders = { # #
          games = {
            name = "Games";
            categories = [ "Game" ];
          };

          preferred-apps = {
            name = "Preferred Apps";
            categories = [ "Preferred" ];
          };

          office = {
            name = "Office";
            categories = [ "Office" ];
          };
        };

        keyboard-shortcuts = {
          customShortcuts = {
            launch-emacsclient = {
              name = "Launch emacsclient";
              command = "xdg-launch emacsclient.desktop";
              binding = "<Ctrl><Super>e";
            };

            open-private-firefox-window = {
              name = "Open private firefox window";
              command = "xdg-launch firefox.desktop:new-private-window";
              binding = "<Ctrl><Alt><Super>b";
            };
          };
        };
      };

      gtk.enable = true;
    };
  };
}
