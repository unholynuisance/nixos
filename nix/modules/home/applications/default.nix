{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.modules.hm.applications;
in
{
  imports = [
    ./calibre.nix
    ./discord.nix
    ./emacs.nix
    ./obs-studio.nix
    ./remmina.nix
    ./zotero.nix
  ];

  options.nuisance.modules.hm.applications = {
    firefox.enable = lib.mkEnableOption "firefox";
    chrome.enable = lib.mkEnableOption "chrome";
    torrent.enable = lib.mkEnableOption "torrent";
    office.enable = lib.mkEnableOption "office";
    latex.enable = lib.mkEnableOption "latex";
    slack.enable = lib.mkEnableOption "slack";
    teams.enable = lib.mkEnableOption "teams";
    telegram.enable = lib.mkEnableOption "telegram";
    krita.enable = lib.mkEnableOption "krita";
    xournal.enable = lib.mkEnableOption "xournal";
  };

  config = {
    home.packages =
      with pkgs;
      let
        inherit (lib.nuisance.utils) mkOptPackages optPackages;
      in
      (mkOptPackages [
        (optPackages cfg.firefox.enable [ firefox ])
        (optPackages cfg.chrome.enable [ google-chrome ])
        (optPackages cfg.torrent.enable [ qbittorrent ])
        (optPackages cfg.office.enable [ libreoffice ])
        (optPackages cfg.slack.enable [ slack ])
        (optPackages cfg.teams.enable [ teams-for-linux ])
        (optPackages cfg.telegram.enable [ telegram-desktop ])
        (optPackages cfg.krita.enable [ krita ])
        (optPackages cfg.xournal.enable [ xournalpp ])
      ]);
  };
}
