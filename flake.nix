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
  } @ args: {
    nixosModules = rec {
      combined = import ./modules/nixos;
      default = combined;
    };

    homeModules = rec {
      combined = import ./modules/home;
      default = combined;
    };

    hosts = {
      asuka = import ./hosts/asuka;
      kaworu = import ./hosts/kaworu;
      ryoji = import ./hosts/ryoji;
    };

    users = {
      unholynuisance = import ./users/unholynuisance;
    };

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
        modules = [self.hosts.asuka];
        specialArgs = {inherit self home-manager disko;};
      };

      # primary virtual host:
      kaworu = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [self.hosts.kaworu];
        specialArgs = {inherit self home-manager disko;};
      };

      # primary work laptop
      # misato = ...

      # iso
      ryoji = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [self.hosts.ryoji];
        specialArgs = {inherit self home-manager disko;};
      };
    };

    homeConfigurations = {
      unholynuisance = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [self.users.unholynuisance];
        extraSpecialArgs = {inherit self;};
      };
    };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
