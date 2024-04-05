{ config, lib, pkgs, self, self', inputs, inputs', ... }@args:
let cfg = config.nuisance.modules.nixos.home-manager;
in {
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options.nuisance.modules.nixos.home-manager = {
    enable = lib.mkEnableOption "home-manager";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = { inherit self self' inputs inputs'; };
    };
  };
}
