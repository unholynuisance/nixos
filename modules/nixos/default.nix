{ config, lib, pkgs, self, ... }: {
  imports = [
    ./boot
    ./services
    ./shells
    ./users
    ./common.nix
    ./gnome.nix
    ./guest.nix
    ./home-manager.nix
    ./libvirt.nix
    ./networkmanager.nix
    ./pipewire.nix
    ./podman.nix
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
