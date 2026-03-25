{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.modules.hm.applications.emacs;
in
{
  options.nuisance.modules.hm.applications.emacs = {
    enable = lib.mkEnableOption "emacs";

    package = lib.mkOption {
      description = "Emacs package to use.";
      type = lib.types.package;
      default = pkgs.emacs;
    };

    finalPackage = lib.mkOption {
      description = "Final package.";
      type = lib.types.package;
      readOnly = true;
      visible = false;
    };
  };

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

    nuisance.modules.hm.applications.emacs = {
      finalPackage =
        let
          pkg = pkgs.nuisance.emacs-with-doom;
          pkg' = pkg.override {
            emacs = cfg.package;
            profileName = "nuisance";
          };
        in
        pkg';
    };

    home.packages = [
      cfg.finalPackage
    ];

    services.emacs = {
      enable = true;
      package = cfg.finalPackage;
      socketActivation.enable = true;
      startWithUserSession = "graphical";

      client = {
        enable = true;
        arguments = [ "--create-frame" ];
      };
    };
  };
}
