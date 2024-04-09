{ config, lib, pkgs, ... }:
let cfg = config.nuisance.modules.hm.fonts;
in {
  options = {
    nuisance.modules.hm.fonts = {
      ibm-plex.enable = lib.mkEnableOption "ibm-plex";
      nerdfonts.enable = lib.mkEnableOption "nerdfonts";
      noto-fonts-cjk-sans.enable = lib.mkEnableOption "noto-fonts-cjk-sans";
    };
  };

  config = {
    home.packages = with pkgs;
      [ ] ++ (lib.optionals cfg.ibm-plex.enable [ # #
        ibm-plex
      ]) ++ (lib.optionals cfg.nerdfonts.enable [ # #
        nerdfonts
      ]) ++ (lib.optionals cfg.noto-fonts-cjk-sans.enable [ # #
        noto-fonts-cjk-sans
      ]);
  };
}
