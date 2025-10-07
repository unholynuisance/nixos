{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.profiles.hm.rei;
in
{
  options.nuisance.profiles.hm.rei = {
    enable = lib.mkEnableOption "rei";
  };

  config = lib.mkIf cfg.enable {
    nuisance.profiles.hm = {
      cli.enable = true;
      graphical.enable = true;
    };

    nuisance.modules.hm = {
      applications = {
        chrome.enable = true;

        office.enable = true;
        torrent.enable = true;

        remmina.enable = true;

        discord.enable = true;
        telegram.enable = true;
        teams.enable = true;
        slack.enable = true;

        zotero.enable = true;

        obs-studio.enable = true;
        krita.enable = true;
        xournal.enable = true;
      };

      games = {
        minecraft = {
          enable = true;
          instances.gtnh = {
            enable = true;
          };
        };

        starsector.enable = true;
      };
    };
  };
}
