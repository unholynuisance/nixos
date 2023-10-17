{
  config,
  lib,
  pkgs,
  ...
} @ args: let
  cfg = config.modules.hm.common;
in {
  options.modules.hm.common= {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [firefox fd ripgrep gnumake cmake gcc libtool perl telegram-desktop];
  };
}
