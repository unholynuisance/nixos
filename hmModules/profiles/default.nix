{ config, lib, pkgs, ... }: {
  imports = [ # #
    ./headless.nix
    ./graphical.nix
    ./games.nix
    ./rei.nix
    ./asuka.nix
    ./kaworu.nix
    ./yui.nix
  ];
}
