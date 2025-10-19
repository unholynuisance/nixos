{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./cataclysm-dda.nix
    ./minecraft
    ./starsector.nix
  ];
}
