{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.modules.hm.fonts;
in
{
  options = {
    nuisance.modules.hm.fonts = {
      ibm-plex.enable = lib.mkEnableOption "ibm-plex";
      nerdfonts.enable = lib.mkEnableOption "nerdfonts";
      noto-fonts-cjk-sans.enable = lib.mkEnableOption "noto-fonts-cjk-sans";
    };
  };

  config = {
    home.packages =
      with pkgs;
      let
        inherit (lib.nuisance.utils) mkOptPackages optPackages;
      in
      (mkOptPackages [
        (optPackages cfg.ibm-plex.enable [ ibm-plex ])
        (optPackages cfg.nerdfonts.enable [ nerdfonts ])
        (optPackages cfg.noto-fonts-cjk-sans.enable [ noto-fonts-cjk-sans ])
      ]);
  };
}
