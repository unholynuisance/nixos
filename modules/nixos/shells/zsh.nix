{ config, lib, pkgs, ... }:
let
  cfg = config.nuisance.modules.nixos.shells.zsh;
in
{
  options.nuisance.modules.nixos.shells.zsh = {
    enable = lib.mkEnableOption "zsh";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
    };
  };
}
