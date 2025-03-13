{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.modules.hm.tools.git;
in
{
  options.nuisance.modules.hm.tools.git = {
    enable = lib.mkEnableOption "git";
  };

  config = lib.mkIf cfg.enable {
    programs.git =
      let
        primaryEmail = lib.nuisance.utils.getPrimaryEmail config;
      in
      {
        enable = true;
        userName = config.home.username;
        userEmail = primaryEmail.address;
      };
  };
}
