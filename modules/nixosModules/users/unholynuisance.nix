{ config, lib, pkgs, ... }@args:
let cfg = config.nuisance.modules.nixos.users.unholynuisance;
in {
  options.nuisance.modules.nixos.users.unholynuisance = {
    enable = lib.mkEnableOption "users.unholynuisance";

    shell = lib.mkPackageOption pkgs "bash" { };

    extraGroups = lib.mkOption {
      description = ''
        The user’s auxiliary groups.
      '';
      type = with lib.types; listOf str;
      default = [ ];
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.unholynuisance = {
      isNormalUser = true;
      description = "Unholy Nuisance";
      shell = cfg.shell;
      extraGroups = cfg.extraGroups;
      initialPassword = "changeme";
    };

    home-manager.users = {
      unholynuisance = import ../../../users/unholynuisance;
    };
  };
}
