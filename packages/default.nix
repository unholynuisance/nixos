{ self, nixpkgs, ... }:
self.lib.forAllSystems (system:
  let pkgs = nixpkgs.legacyPackages.${system};
  in pkgs.lib.attrsets.mergeAttrsList [
    (pkgs.callPackage ./gtnh { })
    (pkgs.callPackage ./proton { })
  ])
