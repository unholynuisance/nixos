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
      with inputs'.doom-emacs.packages;
      lib.attrsets.mergeAttrsList [
        { inherit xwayland-global-shortcut-bridge; }
        { inherit emacs-with-doom; }

        (import ./gtnh { inherit pkgs; })
        (import ./proton { inherit pkgs; })
      ];
  };
}
