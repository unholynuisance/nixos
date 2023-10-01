{
  config,
  lib,
  pkgs,
  ...
} @ args: let
  name = "git";
  cfg = config.modules.home.${name};
in {
  options.modules.home.${name} = {
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
