{ config, lib, pkgs, ... }:
let cfg = config.nuisance.modules.hm.gnome.keyboard-shortcuts;
in {
  options.nuisance.modules.hm.gnome.keyboard-shortcuts = # #
    with lib.types;
    let
      customShortcut = (submodule {
        options = {
          name = lib.mkOption { type = str; };
          command = lib.mkOption { type = str; };
          binding = lib.mkOption { type = str; };
        };
      });

    in {
      enable = lib.mkEnableOption "keyboard-shortcuts";

      customShortcuts = lib.mkOption {
        type = attrsOf customShortcut;
        default = { };
      };
    };

  config = # #
    let
      keyboardShortcuts = {
        # Launchers
        "org/gnome/settings-daemon/plugins/media-keys" = {
          # Home folder
          home = [ "<Ctrl><Super>h" ];
          # Launch calculator
          calculator = [ "<Ctrl><Super>c" ];
          # Launch e-mail client
          email = [ "<Ctrl><Super>m" ];
          # Launch help browser
          help = [ "<Ctrl><Super>F1" ];
          # Launch web browser
          www = [ "<Ctrl><Super>b" ];
          # Search
          search = [ ];
          # Settings
          control-center = [ "<Ctrl><Super>s" ];
        };

        # Keyboard shortcuts: Navigation
        "org/gnome/desktop/wm/keybindings" = {
          # Hide all normal windows
          show-desktop = [ ];
          # Move to workspace on the {left, right}
          switch-to-workspace-left = [ "<Control><Super>Left" ];
          switch-to-workspace-right = [ "<Control><Super>Right" ];
          # Move one monitor {down, left, right, up}
          move-to-monitor-down = [ "<Alt><Super>Down" ];
          move-to-monitor-left = [ "<Alt><Super>Left" ];
          move-to-monitor-right = [ "<Alt><Super>Right" ];
          move-to-monitor-up = [ "<Alt><Super>Up" ];
          # Move window one workspace to the {left, right}
          move-to-workspace-left = [ "<Shift><Super>Left" ];
          move-to-workspace-right = [ "<Shift><Super>Right" ];
          # Move window to workspace {last, 1, 2, 3, 4}
          move-to-workspace-last = [ ];
          move-to-workspace-1 = [ ];
          move-to-workspace-2 = [ ];
          move-to-workspace-3 = [ ];
          move-to-workspace-4 = [ ];
          # Switch applications
          switch-applications = [ "<Super>Tab" ];
          switch-applications-backward = [ "<Shift><Super>Tab" ];
          # Switch system controls
          switch-panels = [ ];
          switch-panels-backward = [ ];
          # Switch system controls directly
          cycle-panels = [ ];
          cycle-panels-backward = [ ];
          # Switch to workspace {last, 1, 2, 3, 4}
          switch-to-workspace-last = [ ];
          switch-to-workspace-1 = [ ];
          switch-to-workspace-2 = [ ];
          switch-to-workspace-3 = [ ];
          switch-to-workspace-4 = [ ];
          # Switch windows
          switch-windows = [ ];
          switch-windows-backward = [ ];
          # Switch windows directly
          cycle-windows = [ ];
          cycle-windows-backward = [ ];
          # Switch windows of an app directly
          cycle-group = [ ];
          cycle-group-backward = [ ];
          # Switch windows of an application
          switch-group = [ "<Alt><Super>Tab" ];
          switch-group-backward = [ "<Alt><Shift><Super>Tab" ];
        };

        # Keybindings: System
        "org/gnome/desktop/wm/keybindings" = {
          # Show the run command prompt
          panel-run-dialog = [ "<Super>F2" ];
        };
        "org/gnome/settings-daemon/plugins/media-keys" = {
          # Lock screen
          screensaver = [ "<Super>l" ];
          # Log out
          logout = [ "<Super>o" ];
          # Show all apps
          toggle-application-view = [ "<Super>a" ];
          # Show the notification list
          toggle-message-tray = [ "<Super>v" ];
          # Show the overview
          toggle-overview = [ ];
        };
        "org/gnome/shell/keybindings" = {
          # Focus the active notification
          focus-active-notification = [ "<Super>n" ];
          # Open the app menu
          open-application-menu = [ ];
        };
        "org/gnome/mutter/wayland/keybindings/restore-shortcuts" = {
          # Restore the keyboard shortcuts
          restore-shortcuts = [ ];
        };

        # Keyboard shortcuts: Typing
        "org/gnome/desktop/wm/keybindings" = {
          # Switch to {next, previous} input source
          switch-input-source = [ "<Super>space" ];
          switch-input-source-backward = [ "<Shift><Super>space" ];
        };

        # Keyboard shrotcuts: Screenshots
        "org/gnome/shell/keybindings" = {
          # Record a screencast interactively
          show-screen-recording-ui = [ ];
          # Take a screenshot
          screenshot = [ ];
          # Take a screenshot interactively
          show-screenshot-ui = [ "<Super>Print" ];
          # Take a screenshot of a window
          screenshot-window = [ ];
        };

        # Keyboard shortcuts: Windows
        "org/gnome/mutter/keybindings" = {
          # View split on left
          toggle-tiled-left = [ "<Super>Left" ];
          # View split on right
          toggle-tiled-right = [ "<Super>Right" ];
        };
        "org/gnome/desktop/wm/keybindings" = {
          # Activate the window menu
          activate-window-menu = [ ];
          # Close window
          close = [ "<Super>F4" ];
          # Hide window
          minimize = [ "<Super>h" ];
          # Lower window below other windows
          lower = [ ];
          # Maximise window
          maximize = [ "<Super>Up" ];
          # Maximise window horizontally
          maximize-horizontally = [ ];
          # Maximise window verically
          maximize-horiontally = [ ];
          # Move window
          begin-move = [ ];
          # Raise window above other windows
          raise = [ ];
          # Raise window if covered, otherwise lower it
          raise-or-lower = [ ];
          # Resize window
          begin-resize = [ ];
          # Restore window
          unmaximize = [ "<Super>Down" ];
          # Toggle fullscreen mode
          toggle-fullscreen = [ "<Super>F11" ];
          # Toggle maximisation state
          toggle-maximized = [ ];
          # Toggle window on all workspaces or one
          toggle-on-all-workspaces = [ ];
        };
      };

      customShortcuts = # #
        with builtins;
        with lib.attrsets;
        let
          path = name:
            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/${name}";

          attrs =
            mapAttrs' (n: v: (nameValuePair (path n) v)) cfg.customShortcuts;

        in attrs // {
          "org/gnome/settings-daemon/plugins/media-keys" = {
            custom-keybindings = map (n: "/${n}/") (attrNames attrs);
          };
        };

    in lib.mkIf cfg.enable (lib.mkMerge [
      { dconf.settings = keyboardShortcuts; }
      { dconf.settings = customShortcuts; }
    ]);
}
