{
  config,
  lib,
  ...
}:
let
  cfg = config.nuisance.profiles.hm.asuka;
in
{
  options.nuisance.profiles.hm.asuka = {
    enable = lib.mkEnableOption "asuka";
  };

  config = lib.mkIf cfg.enable {
    nuisance.profiles.hm = {
      cli.enable = true;
      graphical.enable = true;
    };

    nuisance.modules.hm = {
      applications = {
        office.enable = true;
        torrent.enable = true;

        remmina.enable = true;

        discord.enable = true;
        telegram.enable = true;
        teams.enable = true;

        zotero.enable = true;
      };
    };
  };
}
