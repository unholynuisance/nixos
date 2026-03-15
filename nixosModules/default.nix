{
  config,
  lib,
  pkgs,
  self,
  ...
}:
{
  imports = [
    ./programs
    ./boot
    ./services
    ./shells
    ./users
    ./virtualisation
    ./common.nix
    ./disko.nix
    ./gnome.nix
    ./networkmanager.nix
    ./pipewire.nix
    ./pulseaudio.nix
    ./rtkit.nix
    ./steam.nix
    ./xkb.nix
  ];

  config = {
    nix = {
      channel.enable = false;

      settings = {
        build-dir = "/var/tmp";
      };
    };

    system.stateVersion = "23.05";
  };
}
