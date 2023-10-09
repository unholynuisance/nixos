{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./boot
    ./users
    ./common.nix
    ./gnome.nix
    ./guest.nix
    ./home-manager.nix
    ./networkmanager.nix
    ./pipewire.nix
    ./pulseaudio.nix
    ./rtkit.nix
    ./steam.nix
    ./xserver.nix
  ];

  config = {
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "23.05";
  };
}
