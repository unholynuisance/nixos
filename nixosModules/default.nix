{ config, lib, pkgs, self, ... }: {
  imports = [
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
    nixpkgs.overlays = [ self.overlays.lib self.overlays.pkgs ];

    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "23.05";
  };
}
