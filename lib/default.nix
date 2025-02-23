{ lib, withSystem, ... }:
{
  config.flake = {
    lib = {
      utils = {
        mkNixosConfiguration =
          { self, inputs }:
          { system, modules }:
          withSystem system (
            {
              inputs',
              self',
              pkgs,
              ...
            }:
            inputs.nixpkgs.lib.nixosSystem {
              inherit pkgs modules;
              inherit (pkgs) lib;
              specialArgs = {
                inherit
                  self
                  self'
                  inputs
                  inputs'
                  ;
              };
            }
          );

        mkHomeConfiguration =
          { self, inputs }:
          { system, modules }:
          withSystem system (
            {
              inputs',
              self',
              pkgs,
              ...
            }:
            inputs.home-manager.lib.homeManagerConfiguration {
              inherit pkgs modules;
              extraSpecialArgs = {
                inherit
                  self
                  self'
                  inputs
                  inputs'
                  ;
              };
            }
          );

      };

      types = {
        uuid = lib.types.strMatching "[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}";
      };

      storage = import ./storage.nix { inherit lib; };
    };
  };
}
