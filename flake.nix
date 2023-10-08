{
  description = "A very basic flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    disko,
  } @ inputs: let
    nixosModules = import ./modules/nixos;
    homeModules = import ./modules/home;
  in {
    nixosConfigurations = {
      # personal hosts: shinji, rei, asuka, toji, mari
      # virtual hosts: kaworu
      # work hosts: misato ritsuko gendo kozo naoko yui kyoko ryoji maya shigeru
      # server hosts: adam lilith sachiel shamshel ramiel gaghiel israfel sahaquiel bardiel zeruel arael armisael tabris lilin
      # iso: ryoji

      # primary personal workstation
      # rei = ...;

      # primary personal laptop
      asuka = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [./hosts/asuka];
        specialArgs = {inherit nixosModules homeModules home-manager disko;};
      };

      # primary virtual host:
      kaworu = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [./hosts/kaworu];
        specialArgs = {inherit nixosModules homeModules home-manager disko;};
      };

      # primary work laptop
      # misato = ...

      # iso
      ryoji = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [./hosts/ryoji];
        specialArgs = {inherit nixosModules homeModules nixpkgs home-manager disko;};
      };
    };

    homeConfigurations = {
      unholynuisance = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [./users/unholynuisance];
        extraSpecialArgs = {inherit homeModules;};
      };
    };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
