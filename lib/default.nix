{nixpkgs, ...}: let
  lib = nixpkgs.lib;
in {
  forAllSystems = lib.genAttrs lib.systems.flakeExposed;

  storage = import ./storage.nix {inherit lib;};
}
