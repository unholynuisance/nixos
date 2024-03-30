{ config, lib, pkgs, ... }@args:
let cfg = config.nuisance.modules.nixos.gnome;
in {
  options.nuisance.modules.nixos.gnome = {
    enable = lib.mkEnableOption "gnome";
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome.epiphany
      gnome.geary
      gnome.gedit
    ];
  };
}
