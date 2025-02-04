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
      [ ]
      ++ (lib.optionals cfg.firefox.enable [

        firefox
      ])
      ++ (lib.optionals cfg.chrome.enable [

        google-chrome
      ])
      ++ (lib.optionals cfg.torrent.enable [

        qbittorrent
      ])
      ++ (lib.optionals cfg.office.enable [

        libreoffice
      ])
      ++ (lib.optionals cfg.slack.enable [

        slack
      ])
      ++ (lib.optionals cfg.teams.enable [

        teams-for-linux
      ])
      ++ (lib.optionals cfg.telegram.enable [

        telegram-desktop
      ])
      ++ (lib.optionals cfg.krita.enable [

        krita
      ])
      ++ (lib.optionals cfg.xournal.enable [

        xournalpp
      ]);
  };
}
