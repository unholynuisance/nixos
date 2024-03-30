{ config, lib, pkgs, self, ... }@args: {
  imports = [ self.hmModules.nuisance ];

  config = {
    home.username = "unholynuisance";
    home.homeDirectory = "/home/unholynuisance";

    accounts.email.accounts.personal = {
      address = "mtataryn555@gmail.com";
      primary = true;
    };

    nuisance.modules.hm = {
      common.enable = true;
      gnome.enable = true;
      gtk.enable = true;

      shells = {
        zsh.enable = true;
        starship.enable = true;
      };

      applications = {
        calibre.enable = true;
        discord.enable = true;
        obs-studio.enable = true;
        zotero.enable = true;

        emacs = {
          enable = true;
          package = pkgs.emacs29-gtk3;
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
        direnv.enable = true;
        git.enable = true;
        nix.enable = true;
      };
    };
  };
}
