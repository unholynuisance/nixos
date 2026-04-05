{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.modules.nixos.gnome;
in
{
  options.nuisance.modules.nixos.gnome = {
    enable = lib.mkEnableOption "gnome";
  };

  config = lib.mkIf cfg.enable {
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      epiphany
      geary
      pkgs.gedit
    ];

    xdg.portal = {
      enable = true;
      config.gnome = {
        default = [
          "gnome"
          "gtk"
        ];
      };
    };

    programs.xwayland.enable = true;

    systemd.user.services.xwayland-global-shortcut-bridge = {
      enable = true;
      description = "";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.nuisance.xwayland-global-shortcut-bridge}/bin/xwayland-global-shortcut-bridge";
        Restart = "on-failure";
        RestartSec = "5";
      };
    };
  };
}
