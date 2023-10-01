{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./boot
    ./common.nix
    ./guest.nix
    ./networkmanager.nix
    ./pipewire.nix
    ./pulseaudio.nix
    ./rtkit.nix
  ];

  config = {
    system.stateVersion = "23.05";
  };
}
