{
  config,
  lib,
  pkgs,
  ...
} @ args: let
  cfg = config.nuisance.modules.nixos.gtnh-server;
in {
  options.nuisance.modules.nixos.gtnh-server = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.nuisance.gtnh-server];
  };
}
