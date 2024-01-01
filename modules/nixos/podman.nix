{ config, lib, pkgs, ... }@args:
let cfg = config.nuisance.modules.nixos.virtualisation.podman;
in {
  options.nuisance.modules.nixos.virtualisation.podman = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      enableNvidia = true;
      dockerSocket.enable = true;
    };
  };
}
