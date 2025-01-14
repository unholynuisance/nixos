{ config, osConfig, lib, pkgs, self, inputs', ... }: {
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
    home.packages = lib.optionals (osConfig == null) [ # #
      inputs'.home-manager.packages.home-manager
    ];

    nix = lib.optionalAttrs (osConfig == null) { # #
      package = pkgs.nix;
      settings.experimental-features = [ "nix-command" "flakes" ];
    };

    home.stateVersion = "23.05";
  };
}
