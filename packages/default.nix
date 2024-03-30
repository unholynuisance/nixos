{ config, lib, pkgs, ... }: {
  config = {
    packages = lib.attrsets.mergeAttrsList [
      (import ./gtnh { inherit pkgs; })
      (import ./proton { inherit pkgs; })
    ];
  };
}
