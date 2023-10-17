{
  config,
  lib,
  pkgs,
  ...
} @ args: let
  cfg = config.modules.nixos.steam;
in {
  options.modules.nixos.steam = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
    };
  };
}
