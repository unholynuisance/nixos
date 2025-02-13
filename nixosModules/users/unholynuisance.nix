{
  config,
  lib,
  options,
  pkgs,
  self,
  ...
}:
let
  cfg = config.nuisance.modules.nixos.users.unholynuisance;
in
{
  options.nuisance.modules.nixos.users.unholynuisance = {
    enable = lib.mkEnableOption "unholynuisance";

    shell = lib.mkPackageOption pkgs "bash" { };

    extraGroups = lib.mkOption {
      description = ''
        The user’s auxiliary groups.
      '';
      type = with lib.types; listOf str;
      default = [ ];
    };

    modules = lib.mkOption {
      type = with lib.types; listOf anything;
      default = [ ];
    };
  };

  config = lib.mkIf cfg.enable {
    nuisance.modules.nixos = {

      users.enable = true;
    };

    users.users.unholynuisance = {

      isNormalUser = true;
      description = "Unholy Nuisance";
      shell = cfg.shell;
      extraGroups = cfg.extraGroups;
      initialPassword = "changeme";
    };

    home-manager.users = {

      unholynuisance =
        { ... }:
        {
          imports = [ self.hmModules.unholynuisance ] ++ cfg.modules;
        };
    };
  };
}
