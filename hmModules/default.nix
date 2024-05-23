{ config, lib, pkgs, ... }: {
  imports = [ # #
    ./profiles
    ./gnome
    ./applications
    ./fonts
    ./games
    ./shells
    ./tools
    ./gtk.nix
  ];

  config = {
    # see https://github.com/nix-community/home-manager/issues/2942
    nixpkgs.config.allowUnfreePredicate = pkg: true;
    home.stateVersion = "23.05";
  };
}
