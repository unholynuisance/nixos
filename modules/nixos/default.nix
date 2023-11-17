{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  imports = [
    ./boot
    ./common.nix
    ./gnome.nix
    ./guest.nix
    ./home-manager.nix
    ./libvirt.nix
    ./mc-gtnh-server.nix
    ./networkmanager.nix
    ./pipewire.nix
    ./pulseaudio.nix
    ./rtkit.nix
    ./steam.nix
    ./users
    ./xserver.nix
  ];

  config = {
    nixpkgs.overlays = [
      self.overlays.lib
      self.overlays.pkgs
    ];

    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "23.05";
  };
}
