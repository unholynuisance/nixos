{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.modules.nixos.steam;
in
{
  options.nuisance.modules.nixos.steam = {
    enable = lib.mkEnableOption "steam";

    extraCompatPackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mangohud
    ];

    programs.steam = {
      enable = true;
      protontricks.enable = true;
      extraCompatPackages = cfg.extraCompatPackages;
    };
  };
}
