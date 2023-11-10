{
  config,
  lib,
  pkgs,
  ...
} @ args: let
  name = "grub";
  cfg = config.nuisance.modules.nixos.${name};
in {
  options.nuisance.modules.nixos.${name} = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      useOSProber = true;
      device = "nodev";
      gfxmodeEfi = "2560x1440,auto";
      theme = pkgs.stdenv.mkDerivation {
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
    };
  };
}
