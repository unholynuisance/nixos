{ config, lib, pkgs, ... }@args:
let
  cfg = config.nuisance.modules.nixos.boot.grub;

  poly-dark-theme = pkgs.stdenv.mkDerivation {
    pname = "distro-grub-themes";
    version = "3.1";
    src = pkgs.fetchFromGitHub {
      owner = "shvchk";
      repo = "poly-dark";
      rev = "4850f0c917a0fa320cfd32779b4030baebb2ba8c";
      hash = "sha256-o8dMaXItmmZiOIBnRRYiepPH8bPBR3tjWyALaenXqlM";
    };
    installPhase = "cp -r . $out";
  };
in {
  options.nuisance.modules.nixos.boot.grub = {
    enable = lib.mkEnableOption "grub";

    resolution = lib.mkOption {
      type = lib.types.str;
      default = "1920x1080";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      useOSProber = true;
      device = "nodev";
      gfxmodeEfi = "${cfg.resolution},auto";
      theme = poly-dark-theme;
      splashImage = "${poly-dark-theme}/background.png";
      font = "${poly-dark-theme}/unifont-regular-16.pf2";
    };
  };
}
