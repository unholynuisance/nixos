{ config, lib, pkgs, self, ... }@args:
let
  name = "home-manager";
  cfg = config.nuisance.modules.nixos.${name};
in {
  options.nuisance.modules.nixos.${name} = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = { inherit self; };
    };
  };
}
