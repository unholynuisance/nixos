{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./gtnh
    ./avahi.nix
    ./ssh.nix
  ];
}
