{ config, lib, pkgs, ... }:
let cfg = config.nuisance.profiles.hm.graphical;
in {
  options.nuisance.profiles.hm.graphical = {
    enable = lib.mkEnableOption "graphical";
  };

  config = lib.mkIf cfg.enable {
    nuisance.modules.hm = {
      gnome = {
        enable = true;

        extensions = with pkgs.gnomeExtensions; [
          appindicator
          ip-finder
          freon
        ];

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
              binding = "<Ctrl><Super>p";
            };
          };
        };
      };

      gtk.enable = true;

      applications = {
        # web
        firefox.enable = true;
        chrome.enable = true;
        # messengers
        discord.enable = true;
        telegram.enable = true;
        teams.enable = true;
        slack.enable = true;
        #
        calibre.enable = true;
        zotero.enable = true;
        #
        obs-studio.enable = true;
        krita.enable = true;
        xournal.enable = true;
        office.enable = true;
        #
        torrent.enable = true;
        # holy grail of editors
        emacs = {
          enable = true;
          package = pkgs.emacs29-gtk3;
        };
      };
    };
  };
}
