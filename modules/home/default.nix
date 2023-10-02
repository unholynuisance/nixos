{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./common.nix
    ./emacs.nix
    ./git.nix
  ];

  config = {
    home.stateVersion = "23.05";
  };
}
