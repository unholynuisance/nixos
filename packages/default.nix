{
  self,
  nixpkgs,
  ...
}:
self.lib.forAllSystems (system: let
  pkgs = nixpkgs.legacyPackages.${system};
in {
  gtnh-server = pkgs.callPackage ./gtnh-server {};
})
