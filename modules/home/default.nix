{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./common.nix
    ./git.nix
  ];

  config = {
    home.stateVersion = "23.05";
  };
}
