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
    nix.package = pkgs.nixUnstable;

    nixpkgs.overlays = with self; [ # #
      overlays.lib
      overlays.pkgs
      overlays.electron
    ];

    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "23.05";
  };
}
