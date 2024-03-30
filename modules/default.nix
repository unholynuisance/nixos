{ config, lib, ... }: {
  config.flake = {
    nixosModules = rec { # #
      nuisance = import ./nixosModules;
      default = nuisance;
    };

    hmModules = rec { # #
      nuisance = import ./hmModules;
      default = nuisance;
    };
  };
}
