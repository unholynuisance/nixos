{
  config,
  lib,
  pkgs,
  homeModules,
  ...
} @ args: let
  name = "home-manager";
  cfg = config.modules.nixos.${name};
in {
  options.modules.nixos.${name} = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [home-manager];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = {inherit homeModules;};
    };
  };
}