{
  config,
  lib,
  pkgs,
  inputs',
  ...
}:
{
  config = {
    packages = lib.attrsets.mergeAttrsList [
      (import ./gtnh { inherit pkgs; })
      (import ./proton { inherit pkgs; })
      inputs'.xwayland-global-shortcut-bridge.packages
    ];
  };
}
