{
  config,
  lib,
  pkgs,
  ...
} @ args: let
  cfg = config.modules.hm.emacs;
in {
  options.modules.hm.emacs = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };

    package = lib.mkOption {
      description = ''
        Emacs package to use.
      '';
      type = lib.types.package;
      default = pkgs.emacs;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ibm-plex nerdfonts libvterm];

    programs.emacs = {
      enable = true;
      package = cfg.package;
    };

    services.emacs = {
      enable = true;
      package = cfg.package;
    };
  };
}
