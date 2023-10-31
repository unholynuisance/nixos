{
  config,
  lib,
  pkgs,
  ...
} @ args: let
  cfg = config.modules.hm.minecraft;
in {
  options.modules.hm.minecraft = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [prismlauncher];
  };
}
