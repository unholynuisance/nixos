{ config, lib, pkgs, ... }@args:
let cfg = config.nuisance.modules.hm.applications.emacs;
in {
  options.nuisance.modules.hm.applications.emacs = {
    enable = lib.mkEnableOption "emacs";

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

    services.emacs = {
      enable = true;
      package = cfg.package;

      socketActivation.enable = true;
      startWithUserSession = "graphical";

      client = {
        enable = true;
        arguments = [ "--create-frame" ];
      };
    };
  };
}
