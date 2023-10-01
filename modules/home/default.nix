{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./git.nix
  ];

  config = {
    home.stateVersion = "23.05";
  };
}
