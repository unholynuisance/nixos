{
  config,
  lib,
  pkgs,
  ...
} @ args: let
  name = "networkmanager";
  cfg = config.nuisance.modules.nixos.${name};
in {
  options.nuisance.modules.nixos.${name} = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true;
  };
}
