{ config, lib, pkgs, ... }@args:
let cfg = config.nuisance.modules.hm.git;
in {
  options.nuisance.modules.hm.git = {
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
