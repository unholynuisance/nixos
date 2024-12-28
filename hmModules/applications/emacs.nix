{ config, lib, pkgs, ... }:
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

  config = let
    package = pkgs.buildEnv {
      name = "emacs-with-env";
      paths = with pkgs; [ cfg.package libvterm ];
    };
  in lib.mkIf cfg.enable {
    nuisance.modules.hm = {
      tools = {
        # doom dependencies
        fd.enable = true;
        ripgrep.enable = true;
        # vterm dependencies
        c.enable = true;
        perl.enable = true;
        # dictionaries
        hunspell.enable = true;
      };

      fonts = {
        ibm-plex.enable = true;
        noto-fonts-cjk-sans.enable = true;
      };
    };

    programs.emacs = {
      enable = true;
      inherit package;
    };

    services.emacs = {
      enable = true;
      inherit package;
      socketActivation.enable = true;
      startWithUserSession = "graphical";

      client = {
        enable = true;
        arguments = [ "--create-frame" ];
      };
    };
  };
}
