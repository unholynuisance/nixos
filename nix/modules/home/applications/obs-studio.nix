{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.modules.hm.applications.obs-studio;
in
{
  options.nuisance.modules.hm.applications.obs-studio = {
    enable = lib.mkEnableOption "obs-studio";
  };

  config = lib.mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-vkcapture
        obs-pipewire-audio-capture
      ];
    };
  };
}
