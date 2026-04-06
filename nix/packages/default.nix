{
  lib,
  pkgs,
  inputs',
}:
lib.attrsets.mergeAttrsList [
  { inherit (inputs'.xwayland-global-shortcut-bridge.packages) xwayland-global-shortcut-bridge; }
  { inherit (inputs'.doom-emacs.packages) emacs-with-doom; }

  (import ./gtnh { inherit pkgs; })
  (import ./proton { inherit pkgs; })
]
