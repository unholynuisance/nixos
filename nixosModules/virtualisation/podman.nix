{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.modules.nixos.virtualisation.podman;
in
{
  options.nuisance.modules.nixos.virtualisation.podman = {
    enable = lib.mkEnableOption "podman";
  };

  config = lib.mkIf cfg.enable {
    hardware.nvidia-container-toolkit.enable = true;

    virtualisation.podman = {
      enable = true;
      dockerSocket.enable = true;
    };
  };
}
