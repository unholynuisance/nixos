{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./boot
    ./common.nix
    ./gnome.nix
    ./guest.nix
    ./home-manager.nix
    ./networkmanager.nix
    ./pipewire.nix
    ./pulseaudio.nix
    ./rtkit.nix
    ./xserver.nix
  ];

  config = {
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "23.05";
  };
}
