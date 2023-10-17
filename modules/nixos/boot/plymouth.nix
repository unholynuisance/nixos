{
  config,
  lib,
  pkgs,
  ...
} @ args: let
  cfg = config.modules.nixos.boot.plymouth;
in {
  options.modules.nixos.boot.plymouth = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    boot.plymouth.enable = true;
    boot.kernelParams = ["quiet"];
  };
}
