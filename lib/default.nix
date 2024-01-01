{ nixpkgs, ... }:
let lib = nixpkgs.lib;
in {
  forAllSystems = lib.genAttrs lib.systems.flakeExposed;

  types = {
    uuid = lib.types.strMatching
      "[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}";
  };

  storage = import ./storage.nix { inherit lib; };
}
