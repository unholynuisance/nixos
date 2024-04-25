{ config, lib, pkgs, ... }:
let cfg = config.nuisance.profiles.hm.graphical;
in {
  options.nuisance.profiles.hm.graphical = {
    enable = lib.mkEnableOption "graphical";
  };

  config = lib.mkIf cfg.enable {
    nuisance.profiles.hm.headless.enable = true;

    nuisance.modules.hm = {
      gnome.enable = true;
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
        latex.enable = true;
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
