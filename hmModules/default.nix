{
  config,
  osConfig,
  lib,
  pkgs,
  self,
  inputs',
  ...
}:
{
  imports = [

    ./profiles
    ./gnome
    ./applications
    ./fonts
    ./games
    ./shells
    ./tools
    ./gtk.nix
  ];

  config = lib.mkMerge [
    (lib.mkIf (osConfig == null) {
      home.packages = [

        inputs'.home-manager.packages.home-manager
      ];

      nix = {

        package = pkgs.nix;
        settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
      };

      targets.genericLinux.enable = true;
    })
    { home.stateVersion = "23.05"; }
  ];
}
