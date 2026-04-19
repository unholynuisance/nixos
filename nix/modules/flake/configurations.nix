{
  self,
  inputs,
  ...
}:
let
  mkNixosConfiguration = self.lib.utils.mkNixosConfiguration {
    inherit self inputs;
  };

  mkHomeConfiguration = self.lib.utils.mkHomeConfiguration {
    inherit self inputs;
  };
in
{
  config.flake = {
    nixosConfigurations = {
      # personal: shinji, rei, asuka, toji, mari
      # virtual: kaworu
      # work: misato, ritsuko
      # _: gendo, kozo
      # _: makoto, maya, shigeru
      # server: adam, lilith, sachiel, shamshel, ramiel, gaghiel, israfel, sahaquiel, bardiel, zeruel, arael, armisael, tabris, lilin
      # wsl: naoko, kyoko, yui
      # iso: ryoji

      # desktop
      rei = mkNixosConfiguration {
        system = "x86_64-linux";
        modules = [ self.nixosModules.rei ];
      };

      # laptop
      asuka = mkNixosConfiguration {
        system = "x86_64-linux";
        modules = [ self.nixosModules.asuka ];
      };

      # test vm
      kaworu = mkNixosConfiguration {
        system = "x86_64-linux";
        modules = [ self.nixosModules.kaworu ];
      };

      # work laptop
      # misato = ...

      # wsl
      yui = mkNixosConfiguration {
        system = "x86_64-linux";
        modules = [ self.nixosModules.yui ];
      };

      # iso
      ryoji = mkNixosConfiguration {
        system = "x86_64-linux";
        modules = [ self.nixosModules.ryoji ];
      };
    };

    homeConfigurations = {
      "unholynuisance@rei" = mkHomeConfiguration {
        system = "x86_64-linux";
        modules = [
          self.homeModules.unholynuisance
          { nuisance.profiles.hm.rei.enable = true; }
        ];
      };
    };
  };
}
