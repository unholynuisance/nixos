{
  config,
  lib,
  pkgs,
  inputs',
  ...
}:
{
  config = {
    packages =
      with inputs'.xwayland-global-shortcut-bridge.packages;
      lib.attrsets.mergeAttrsList [
        { inherit xwayland-global-shortcut-bridge; }

        (import ./gtnh { inherit pkgs; })
        (import ./proton { inherit pkgs; })
      ];
  };
}
