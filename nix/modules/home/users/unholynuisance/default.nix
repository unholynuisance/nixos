{
  config,
  lib,
  pkgs,
  self,
  ...
}:
{
  imports = [ self.homeModules.all ];

  config = {
    home.username = "unholynuisance";
    home.homeDirectory = "/home/unholynuisance";

    accounts.email.accounts.personal = {
      address = "mtataryn555@gmail.com";
      primary = true;
    };
  };
}
