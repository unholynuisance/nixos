{
  config,
  lib,
  pkgs,
  ...
} @ args: let
  cfg = config.nuisance.modules.hm.common;
in {
  options.nuisance.modules.hm.common = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [firefox fd ripgrep gnumake cmake gcc libtool perl telegram-desktop texlive.combined.scheme-full];
  };
}
