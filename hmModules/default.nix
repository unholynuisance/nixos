{ config, lib, pkgs, ... }: {
  imports = [
    ./applications
    ./fonts
    ./games
    ./shells
    ./tools
    ./common.nix
    ./gnome.nix
    ./gtk.nix
  ];

  config = {
    # see https://github.com/nix-community/home-manager/issues/2942
    nixpkgs.config.allowUnfreePredicate = pkg: true;
    home.stateVersion = "23.05";
  };
}
