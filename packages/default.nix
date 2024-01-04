{ self, nixpkgs, ... }:
self.lib.forAllSystems (system:
  let pkgs = nixpkgs.legacyPackages.${system};
  in {
    gtnh = pkgs.callPackage ./gtnh { };
    proton = pkgs.callPackage ./proton { };
  })
