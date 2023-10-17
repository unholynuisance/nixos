{
  config,
  lib,
  pkgs,
  ...
} @ args: let
  cfg = config.modules.hm.git;
in {
  options.modules.hm.git = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = config.home.username;
      userEmail = config.accounts.email.accounts.personal.address;
    };
  };
}
