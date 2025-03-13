{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

    ./cli.nix
    ./graphical.nix
    ./gnome.nix
    ./games.nix
    ./rei.nix
    ./asuka.nix
    ./kaworu.nix
    ./yui.nix
  ];
}
