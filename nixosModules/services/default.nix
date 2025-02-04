{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

    ./minecraft
    ./avahi.nix
    ./ssh.nix
  ];
}
