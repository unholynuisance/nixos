{ config, lib, pkgs, self, ... }: {
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
    ./xserver.nix
  ];

  config = {
    nixpkgs.overlays = lib.attrValues self.overlays;

    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "23.05";
  };
}
