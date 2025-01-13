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

    # see https://github.com/nix-community/home-manager/issues/2942
    nixpkgs = {
      config.allowUnfreePredicate = pkg: true;
      overlays = lib.attrValues self.overlays;
    };

    home.stateVersion = "23.05";
  };
}
