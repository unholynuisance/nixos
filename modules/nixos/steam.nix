{ config, lib, pkgs, ... }@args:
let cfg = config.nuisance.modules.nixos.steam;
in {
  options.nuisance.modules.nixos.steam = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };

    extraCompatTools = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
    };
  };

  config = lib.mkIf cfg.enable {
    programs.steam = { enable = true; };

    environment.systemPackages = with pkgs; [ protontricks mangohud ];
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        lib.concatStringsSep ":" cfg.extraCompatTools;
    };
  };
}
