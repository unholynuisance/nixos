{ config, lib, pkgs, ... }@args:
let cfg = config.nuisance.modules.hm.tools.git;
in {
  options.nuisance.modules.hm.tools.git = {
    enable = lib.mkOption {
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
