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

        getPrimaryEmail =
          config:
          let
            cfg = config.accounts.email;
          in
          (lib.findFirst (a: a.primary) null (lib.attrsets.attrValues cfg.accounts));

        mkOptPackages =
          packages:
          let
            packages' = lib.filter (p: p.enable) packages;
            packages'' = (lib.map (p: p.packages) packages');
          in
          (lib.fold (a: b: a ++ b) [ ] packages'');

        optPackages = enable: packages: { inherit packages enable; };
      };

      types = {
        uuid = lib.types.strMatching "[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}";
      };

      storage = import ./storage.nix { inherit lib; };
    };
  };
}
