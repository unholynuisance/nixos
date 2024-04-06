{ config, lib, pkgs, ... }:
let cfg = config.nuisance.modules.nixos.virtualisation.podman;
in {
  options.nuisance.modules.nixos.virtualisation.podman = {
    enable = lib.mkEnableOption "podman";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      enableNvidia = true;
      dockerSocket.enable = true;
    };
  };
}
