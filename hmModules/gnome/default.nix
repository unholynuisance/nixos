{ config, lib, pkgs, ... }:
let cfg = config.nuisance.modules.hm.gnome;
in {
  imports = [ ./keyboard-shortcuts.nix ];

  options.nuisance.modules.hm.gnome = # #
    with lib.types;
    let
      appFolder = (submodule {
        options = {
          name = lib.mkOption { type = str; };

          translate = lib.mkOption {
            type = bool;
            default = false;
          };

          apps = lib.mkOption {
            type = listOf str;
            default = [ ];
          };

          categories = lib.mkOption {
            type = listOf str;
            default = [ ];
          };
        };
      });

    in {
      enable = lib.mkEnableOption "gnome";

      extensions = lib.mkOption {
        type = listOf package;
        default = [ ];
      };

      favouriteApps = lib.mkOption {
        type = listOf str;
        default = [ ];
      };

      appFolders = lib.mkOption {
        type = attrsOf appFolder;
        default = { };
      };
    };

  config = let
    appsToDesktopFiles = apps: map (a: "${a}.desktop") apps;

    settings = {
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
    };

    extensions = {
      "org/gnome/shell" = {
        disable-user-extensions = false;

        enabled-extensions =
          lib.lists.forEach cfg.extensions (x: x.passthru.extensionUuid);
      };
    };

    favouriteApps = {
      "org/gnome/shell" = {
        favorite-apps = appsToDesktopFiles cfg.favouriteApps;
      };
    };

    appFolders = # #
      with builtins;
      with lib.attrsets;
      let
        path = name: "org/gnome/desktop/app-folders/folders/${name}";

        attrs = mapAttrs' # #
          (n: v:
            (nameValuePair # #
              (path n) (v // { apps = appsToDesktopFiles v.apps; })))
          (cfg.appFolders);

      in attrs // {
        "org/gnome/desktop/app-folders" = {
          folder-children = attrNames cfg.appFolders;
        };
      };

  in lib.mkIf cfg.enable (lib.mkMerge [
    {
      nuisance.modules.hm.gnome = { keyboard-shortcuts.enable = true; };
      dconf.settings = settings;
    }
    {
      home.packages = cfg.extensions;
      dconf.settings = extensions;
    }
    { dconf.settings = favouriteApps; }
    { dconf.settings = appFolders; }
  ]);
}
