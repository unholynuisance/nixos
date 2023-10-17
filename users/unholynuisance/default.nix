{
  config,
  lib,
  pkgs,
  self,
  ...
} @ args: {
  imports = [
    self.homeModules.combined
  ];

  config = {
    home.username = "unholynuisance";
    home.homeDirectory = "/home/unholynuisance";

    accounts.email.accounts.personal = {
      address = "mtataryn555@gmail.com";
      primary = true;
    };

    modules.hm.common.enable = true;
    modules.hm.discord.enable = true;
    modules.hm.emacs.enable = true;
    modules.hm.emacs.package = pkgs.emacs29-pgtk;
    modules.hm.git.enable = true;
    modules.hm.gnome.enable = true;
    modules.hm.gtk.enable = true;
  };
}
