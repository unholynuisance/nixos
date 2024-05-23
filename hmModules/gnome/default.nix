{ config, lib, pkgs, ... }:
let cfg = config.nuisance.modules.hm.gnome;
in {
  imports = [ ./keyboard-shortcuts.nix ];

  options.nuisance.modules.hm.gnome = {
    enable = lib.mkEnableOption "gnome";

    extensions = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
    };
  };

  config = lib.mkIf cfg.enable {
    nuisance.modules.hm.gnome = { keyboard-shortcuts.enable = true; };

    home.packages = cfg.extensions;

    dconf.settings = {
      # Touchpad
      "org/gnome/desktop/peripherals/touchpad" = {
        # Tap to click
        tap-to-click = true;
        # Scroll method
        two-finger-scrolling-enabled = true;
      };

      # Appearance
      "org/gnome/desktop/interface" = {
        # Style
        color-scheme = "prefer-dark";
      };

      # Power
      "org/gnome/desktop/interface" = {
        # Show battery percentage
        show-battery-percentage = true;
      };

      # Multitasking
      "org/gnome/mutter" = {
        # Active screen edges
        edge-tiling = true;
        # Workspaces
        dynamic-workspaces = true;
        # Multi-monitor
        workspaces-only-on-primary = true;
      };
      "org/gnome/app-switcher" = {
        # App switching
        current-workspace-only = true;
      };

      "org/gnome/shell" = {
        favorite-apps = [
          "firefox.desktop"
          "org.gnome.Console.desktop"
          "emacs.desktop"
          "org.gnome.Nautilus.desktop"
        ];

        disable-user-extensions = false;

        enabled-extensions =
          lib.lists.forEach cfg.extensions (x: x.passthru.extensionUuid);
      };
    };
  };
}
