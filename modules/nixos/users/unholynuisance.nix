{
  config,
  lib,
  pkgs,
  ...
} @ args: let
  cfg = config.nuisance.modules.nixos.users.unholynuisance;
in {
  options.nuisance.modules.nixos.users.unholynuisance = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.unholynuisance = {
      isNormalUser = true;
      description = "Unholy Nuisance";
      extraGroups = ["wheel" "networkmanager"];
    };

    home-manager.users = {
      unholynuisance = import ../../../users/unholynuisance;
    };
  };
}
