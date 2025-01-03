{
  description = "A very basic flake";

  inputs = {
    nixpkgs = { # #
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixpkgs-master = { # #
      url = "github:nixos/nixpkgs/master";
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

    wsl = { # #
      url = "github:nix-community/nixos-wsl";
    };

    xkeyboard-config-src = { # #
      url = "github:unholynuisance/xkeyboard-config";
      flake = false;
    };

    doom-emacs = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "";
    };

    doom-emacs-config = {
      url = "github:unholynuisance/.doom.d";
      flake = false;
    };
  };

  outputs = { self, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; }
    ({ config, lib, inputs, withSystem, ... }: {
      imports = [ # #
        ./lib
        ./overlays
        ({ config, lib, inputs, ... }: {
          config.flake = {
            nixosModules = rec { # #
              default = all;
              all = import ./nixosModules;

              rei = import ./nixosModules/hosts/rei;
              asuka = import ./nixosModules/hosts/asuka;
              kaworu = import ./nixosModules/hosts/kaworu;
              ryoji = import ./nixosModules/hosts/ryoji;
              yui = import ./nixosModules/hosts/yui;
            };

            hmModules = rec { # #
              default = all;
              all = import ./hmModules;

              unholynuisance = import ./hmModules/users/unholynuisance;
            };
          };
        })
      ];

      config = {
        systems = [ "x86_64-linux" "aarch64-linux" ];

        perSystem = { config, lib, pkgs, ... }: { # #
          imports = [ ./packages ];

          config = with pkgs; { # #
            devShells = {
              default = mkShell {
                packages = [ # #
                  nixd
                  nixfmt-classic
                  nix-output-monitor
                ];
              };
            };

            formatter = nixfmt-classic;
          };
        };

        flake = let
          mkNixosConfiguration = self.lib.utils.mkNixosConfiguration { # #
            inherit self inputs;
          };

          mkHomeConfiguration = self.lib.utils.mkHomeConfiguration { # #
            inherit self inputs;
          };
        in {

          nixosConfigurations = {
            # personal. shinji, rei, asuka, toji, mari
            # virtual. kaworu
            # work. misato ritsuko
            # _: gendo kozo
            # _: makoto maya shigeru
            # server. adam lilith sachiel shamshel ramiel gaghiel israfel sahaquiel bardiel zeruel arael armisael tabris lilin
            # wsl: naoko, kyoko, yui
            # iso: ryoji

            # primary personal desktop
            rei = mkNixosConfiguration {
              system = "x86_64-linux";
              modules = [ self.nixosModules.rei ];
            };

            # primary personal laptop
            asuka = mkNixosConfiguration {
              system = "x86_64-linux";
              modules = [ self.nixosModules.asuka ];
            };

            # primary virtual host:
            kaworu = mkNixosConfiguration {
              system = "x86_64-linux";
              modules = [ self.nixosModules.kaworu ];
            };

            # primary work laptop
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
            unholynuisance = mkHomeConfiguration {
              system = "x86_64-linux";
              modules = [ self.modules.unholynuisance ];
            };
          };
        };
      };
    });
}
