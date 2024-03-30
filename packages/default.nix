{ self, nixpkgs, ... }:
self.lib.forAllSystems (system:
  let pkgs = nixpkgs.legacyPackages.${system};
  in pkgs.lib.attrsets.mergeAttrsList [
    (import ./gtnh { inherit pkgs; })
    (import ./proton { inherit pkgs; })
  ])
