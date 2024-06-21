{ config, lib, pkgs, ... }:
let cfg = config.nuisance.modules.nixos.services.avahi;
in {
  options.nuisance.modules.nixos.services.avahi = {
    enable = lib.mkEnableOption "avahi";
  };

  config = lib.mkIf cfg.enable {
    services.avahi = { # #
      enable = true;
      nssmdns4 = true;
    };
  };
}
