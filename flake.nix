{
  description = "A very basic flake";

  inputs = {
    nixpkgs = {
      # url = "github:nixos/nixpkgs/nixos-unstable";
      url = "github:unholynuisance/nixpkgs/nixos-unstable";
    };

    nixpkgs-master = {
      # url = "github:nixos/nixpkgs/master";
      url = "github:unholynuisance/nixpkgs/master";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    devenv = {
      url = "github:cachix/devenv";
    };

    nix2container = {
      url = "github:nlewo/nix2container";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mk-shell-bin = {
      url = "github:rrbutani/nix-mk-shell-bin";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wsl = {
      url = "github:nix-community/nixos-wsl";
    };

    xkeyboard-config-src = {
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

  outputs =
    { self, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } (
      {
        inputs,
        ...
      }:
      {
        imports = [
          inputs.devenv.flakeModule
          inputs.treefmt-nix.flakeModule
          ./lib
          ./overlays
          (
            { lib, self, ... }:
            {
              config.perSystem =
                { system, ... }:
                {
                  _module.args.pkgs = import inputs.nixpkgs {
                    inherit system;
                    overlays = lib.attrsets.attrValues self.overlays;
                    config.allowUnfree = true;
                  };
                };
            }
          )
          (
            {
              ...
            }:
            {
              config.flake = {
                nixosModules = rec {
                  default = all;
                  all = import ./nixosModules;

                  rei = import ./nixosModules/hosts/rei;
                  asuka = import ./nixosModules/hosts/asuka;
                  kaworu = import ./nixosModules/hosts/kaworu;
                  ryoji = import ./nixosModules/hosts/ryoji;
                  yui = import ./nixosModules/hosts/yui;
                };

                homeModules = rec {
                  default = all;
                  all = import ./homeModules;

                  unholynuisance = import ./homeModules/users/unholynuisance;
                };
              };
            }
          )
        ];

        config = {
          systems = [
            "x86_64-linux"
            "aarch64-linux"
          ];

          perSystem =
            {
              config,
              lib,
              pkgs,
              ...
            }:
            {
              imports = [
                ./packages
              ];

              config = with pkgs; {
                devenv.shells.default = {
                  packages = [ config.treefmt.build.wrapper ] ++ lib.attrValues config.treefmt.build.programs;

                  languages = {
                    nix = {
                      enable = true;
                      lsp.package = nixd;
                    };
                  };
                };

                treefmt.programs = {
                  nixfmt.enable = true;
                };
              };
            };

          flake =
            let
              mkNixosConfiguration = self.lib.utils.mkNixosConfiguration {
                inherit self inputs;
              };

              mkHomeConfiguration = self.lib.utils.mkHomeConfiguration {
                inherit self inputs;
              };
            in
            {

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
        };
      }
    );
}
