{inputs}:
with inputs; let
  lib = nixpkgs.lib;
in
  home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.x86_64-linux;

    modules = [
      ./../../modules/home

      ({
        config,
        lib,
        ...
      }: {
        config = {
          home.username = "unholynuisance";
          home.homeDirectory = "/home/unholynuisance";

          accounts.email.accounts.personal = {
            address = "mtataryn555@gmail.com";
            primary = true;
          };

          modules.home.git.enable = true;
        };
      })
    ];
  }
