{ config, lib, pkgs, ... }@args:
let cfg = config.nuisance.modules.hm.common;
in {
  options.nuisance.modules.hm.common = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      fd
      ripgrep
      xdg-launch
      gcc
      gnumake
      cmake
      unzip
      libtool
      perl
      firefox
      google-chrome
      qbittorrent
      libreoffice
      hunspell
      hunspellDicts.uk-ua
      hunspellDicts.en-us-large
      texlive.combined.scheme-full
      slack
      teams-for-linux
      telegram-desktop
      krita
      xournalpp
    ];
  };
}
