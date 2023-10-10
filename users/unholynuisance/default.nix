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

    modules.home.common.enable = true;
    modules.home.emacs.enable = true;
    modules.home.git.enable = true;
    modules.home.gnome.enable = true;
  };
}
