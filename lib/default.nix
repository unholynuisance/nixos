{ config, inputs, withSystem, ... }: {
  config.flake = {
    lib = let inherit (inputs.nixpkgs) lib;
    in {
      utils = {
        mkNixosConfiguration = # #
          { self, inputs }:
          { system, modules }:
          withSystem system ({ inputs', self', system, ... }@context:
            inputs.nixpkgs.lib.nixosSystem {
              inherit system modules;
              specialArgs = { inherit self self' inputs inputs'; };
            });

        mkHomeConfiguration = # #
          { self, inputs }:
          { system, modules }:
          withSystem system ({ inputs', self', pkgs, ... }@context:
            inputs.home-manager.lib.homeManagerConfiguration {
              inherit pkgs modules;
              extraSpecialArgs = { inherit self self' inputs inputs'; };
            });

      };

      types = {
        uuid = lib.types.strMatching
          "[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}";
      };

      storage = import ./storage.nix { inherit lib; };
    };
  };
}
