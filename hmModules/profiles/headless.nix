{ config, lib, pkgs, ... }:
let cfg = config.nuisance.profiles.hm.headless;
in {
  options.nuisance.profiles.hm.headless = { # #
    enable = lib.mkEnableOption "headless";
  };

  config = lib.mkIf cfg.enable {
    nuisance.modules.hm = {
      shells = {
        zsh.enable = true;
        starship.enable = true;
      };

      applications = { emacs.enable = true; };

      tools = {
        zip.enable = true;
        fd.enable = true;
        ripgrep.enable = true;
        direnv.enable = true;
        git.enable = true;
      };
    };
  };
}
