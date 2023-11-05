{
  config,
  lib,
  pkgs,
  ...
} @ args: let
  cfg = config.nuisance.modules.hm.minecraft;
in {
  options.nuisance.modules.hm.minecraft = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [prismlauncher-qt5];
  };
}
