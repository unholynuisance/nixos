{ config, lib, pkgs, ... }:
let
  cfg = config.nuisance.modules.hm.shells.zsh;
in
{
  options.nuisance.modules.hm.shells.zsh = {
    enable = lib.mkEnableOption "zsh";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      enableAutosuggestions = true;
      enableCompletion = true;
      enableVteIntegration = true;

      history = {
        path = "${config.xdg.dataHome}/zsh/zsh_history";
      };
    };
  };
}
