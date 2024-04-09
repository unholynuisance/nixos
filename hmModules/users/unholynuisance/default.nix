{ config, lib, pkgs, self, ... }: {
  imports = [ self.hmModules.all ];

  config = {
    home.username = "unholynuisance";
    home.homeDirectory = "/home/unholynuisance";

    accounts.email.accounts.personal = {
      address = "mtataryn555@gmail.com";
      primary = true;
    };

    nuisance.modules.hm = {
      gnome.enable = true;
      gtk.enable = true;

      shells = {
        zsh.enable = true;
        starship.enable = true;
      };

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
        #
        torrent.enable = true;
        # holy grail of editors
        emacs = {
          enable = true;
          package = with pkgs; emacs29-gtk3;
        };
      };

      games = {
        minecraft = {
          enable = true;
          instances.gtnh.enable = true;
        };

        cataclysm-dda.enable = true;
      };

      tools = {
        zip.enable = true;
        xdg-launch.enable = true;

        fd.enable = true;
        ripgrep.enable = true;
        direnv.enable = true;
        git.enable = true;
        nix.enable = true;
        latex.enable = true;
      };
    };
  };
}
