{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./boot
    ./common.nix
  ];
}
