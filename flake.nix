{
  description = "A very basic flake";

  inputs = {
    nixpkgs = { # #
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    flake-parts = { # #
      url = "github:hercules-ci/flake-parts";
    };

    home-manager = { # #
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = { # #
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xkeyboard-config-src = { # #
      url = "github:unholynuisance/xkeyboard-config";
      flake = false;
    };
  };

  outputs = { self, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; }
    ({ config, lib, inputs, withSystem, ... }: {
      imports = [ ./lib ./overlays ./modules ];

      config = {
        systems = [ "x86_64-linux" "aarch64-linux" ];

        perSystem = { config, lib, pkgs, ... }: { # #
          imports = [ ./packages ];
          config = { # #
            formatter = pkgs.nixfmt;
          };
        };

        flake = let
          mkNixosConfiguration =
            self.lib.utils.mkNixosConfiguration { inherit self inputs; };
          mkHomeConfiguration =
            self.lib.utils.mkHomeConfiguration { inherit self inputs; };
        in {
          hosts = {
            rei = import ./hosts/rei;
            asuka = import ./hosts/asuka;
            kaworu = import ./hosts/kaworu;
            ryoji = import ./hosts/ryoji;
          };

          users = { unholynuisance = import ./users/unholynuisance; };

          nixosConfigurations = {
            # personal hosts: shinji, rei, asuka, toji, mari
            # virtual hosts: kaworu
            # work hosts: misato ritsuko
            # _: gendo kozo
            # _: makoto maya shigeru
            # server hosts: adam lilith sachiel shamshel ramiel gaghiel israfel sahaquiel bardiel zeruel arael armisael tabris lilin
            # wsl: naoko, kyoko, yui
            # iso: ryoji

            # primary personal laptop
            rei = mkNixosConfiguration {
              system = "x86_64-linux";
              modules = [ self.hosts.rei ];
            };

            # primary personal laptop
            asuka = mkNixosConfiguration {
              system = "x86_64-linux";
              modules = [ self.hosts.asuka ];
            };

            # primary virtual host:
            kaworu = mkNixosConfiguration {
              system = "x86_64-linux";
              modules = [ self.hosts.kaworu ];
            };

            # # primary work laptop
            # # misato = ...

            # iso
            ryoji = mkNixosConfiguration {
              system = "x86_64-linux";
              modules = [ self.hosts.ryoji ];
            };
          };

          homeConfigurations = {
            unholynuisance = mkHomeConfiguration {
              system = "x86_64-linux";
              modules = [ self.users.unholynuisance ];
            };
          };
        };
      };
    });
}
