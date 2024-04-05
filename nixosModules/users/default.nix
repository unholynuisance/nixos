{ config, lib, pkgs, self, self', inputs, inputs', ... }@args:
let cfg = config.nuisance.modules.nixos.users;
in {
  imports = [ # #
    inputs.home-manager.nixosModules.home-manager
    ./unholynuisance.nix
  ];

  options.nuisance.modules.nixos.users = {
    enable = lib.mkEnableOption "users";
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
