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

    nuisance.modules.hm = {
      common.enable = true;
      discord.enable = true;
      emacs.enable = true;
      emacs.package = pkgs.emacs29-gtk3;
      git.enable = true;
      gnome.enable = true;
      gtk.enable = true;
      minecraft.enable = true;
    };
  };
}
