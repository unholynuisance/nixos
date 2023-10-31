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

    modules.hm = {
      common.enable = true;
      discord.enable = true;
      emacs.enable = true;
      emacs.package = pkgs.emacs29-pgtk;
      git.enable = true;
      gnome.enable = true;
      gtk.enable = true;
      minecraft.enable = true;
    };
  };
}
