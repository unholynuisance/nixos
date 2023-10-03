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
    # see https://github.com/nix-community/home-manager/issues/2942
    nixpkgs.config.allowUnfreePredicate = pkg: true;
    home.stateVersion = "23.05";
  };
}
