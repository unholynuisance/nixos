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

      package =
        with pkgs;
        steam.override {
          extraPkgs = _: [
            jq
            cabextract
            wget
            git
            pkgsi686Linux.libpulseaudio
            pkgsi686Linux.freetype
            pkgsi686Linux.xorg.libXcursor
            pkgsi686Linux.xorg.libXcomposite
            pkgsi686Linux.xorg.libXi
          ];
        };
    };
  };
}
