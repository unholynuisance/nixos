{
  config,
  lib,
  ...
}:
let
  cfg = config.nuisance.profiles.hm.cli;
in
{
  options.nuisance.profiles.hm.cli = {

    enable = lib.mkEnableOption "cli";
  };

  config = lib.mkIf cfg.enable {
    nuisance.modules.hm = {
      shells = {
        zsh.enable = true;
        starship.enable = true;
      };

      applications = {
        emacs.enable = true;
      };

      tools = {
        zip.enable = true;
        xdg.enable = true;

        fd.enable = true;
        ripgrep.enable = true;
        direnv.enable = true;
        git.enable = true;
        nix.enable = true;
        latex.enable = true;
      };
    };
  };
}
