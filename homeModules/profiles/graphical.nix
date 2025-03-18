{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.profiles.hm.graphical;
in
{
  options.nuisance.profiles.hm.graphical = {
    enable = lib.mkEnableOption "graphical";
  };

  config = lib.mkIf cfg.enable {
    nuisance.profiles.hm = {
      gnome.enable = true;
    };

    nuisance.modules.hm = {
      applications = {
        firefox.enable = lib.mkDefault true;

        emacs = {
          enable = lib.mkDefault true;
          package = lib.mkDefault pkgs.emacs29-gtk3;
        };
      };
    };
  };
}
