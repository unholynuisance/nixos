{ config, lib, pkgs, ... }@args:
let cfg = config.nuisance.modules.hm.applications.emacs;
in {
  options.nuisance.modules.hm.applications.emacs = {
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
    home.packages = with pkgs; [
      ibm-plex
      nerdfonts
      noto-fonts-cjk-sans
      libvterm
    ];

    programs.emacs = {
      enable = true;
      package = cfg.package;
    };

    # services.emacs = {
    #   enable = true;
    #   package = cfg.package;
    # };
  };
}
