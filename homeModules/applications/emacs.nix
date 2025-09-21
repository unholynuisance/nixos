{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.nuisance.modules.hm.applications.emacs;
in
{
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

  imports = [

    inputs.doom-emacs.hmModule
  ];

  config = lib.mkIf cfg.enable {
    nuisance.modules.hm = {
      tools = {
        fd.enable = true;
        ripgrep.enable = true;
      };

      fonts = {
        ibm-plex.enable = true;
        noto-fonts-cjk-sans.enable = true;
      };
    };

    programs.doom-emacs = {
      enable = true;
      emacs = cfg.package;
      doomDir = inputs.doom-emacs-config;
      tangleArgs = ".";
      extraPackages = epkgs: [ epkgs.treesit-grammars.with-all-grammars ];
    };

    services.emacs = {
      enable = true;
      socketActivation.enable = true;
      startWithUserSession = "graphical";

      client = {
        enable = true;
        arguments = [ "--create-frame" ];
      };
    };
  };
}
