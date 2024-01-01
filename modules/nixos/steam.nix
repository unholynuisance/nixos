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
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ protontricks mangohud ];

    programs.steam = { enable = true; };
  };
}
