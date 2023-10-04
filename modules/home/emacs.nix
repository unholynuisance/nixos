{
  config,
  lib,
  pkgs,
  ...
} @ args: let
  name = "emacs";
  cfg = config.modules.home.${name};
in {
  options.modules.home.${name} = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ibm-plex libvterm];

    programs.emacs = {
      enable = true;
      package = pkgs.emacs29-gtk3;
    };

    services.emacs = {
      enable = true;
      package = pkgs.emacs29-gtk3;
    };
  };
}
