{ config, lib, pkgs, self, ... }@args:
let cfg = config.nuisance.modules.nixos.home-manager;
in {
  options.nuisance.modules.nixos.home-manager = {
    enable = lib.mkEnableOption "home-manager";
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
