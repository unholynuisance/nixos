{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./boot
    ./common.nix
    ./networkmanager.nix
    ./pipewire.nix
    ./pulseaudio.nix
    ./rtkit.nix
  ];
}
