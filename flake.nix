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
    ...
  } @ inputs: {
    nixosConfigurations = {
      # personal hosts: shinji, rei, asuka, toji, mari
      # virtual hosts: kaworu
      # work hosts: misato ritsuko gendo kozo naoko yui kyoko ryoji maya shigeru
      # server hosts: adam lilith sachiel shamshel ramiel gaghiel israfel sahaquiel bardiel zeruel arael armisael tabris lilin

      # primary personal workstation
      # rei = import ...;

      # primary personal laptop
      asuka = import ./hosts/asuka {inherit inputs;};

      # secondary personal laptop
      shinji = import ./hosts/shinji {inherit inputs;};

      # primary work laptop
      # misato = import ...;
    };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
