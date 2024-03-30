{ config, lib, pkgs, ... }@args:
let cfg = config.nuisance.modules.nixos.guest;
in {
  options.nuisance.modules.nixos.guest = {
    enable = lib.mkEnableOption "guest";
  };

  config = lib.mkIf cfg.enable {
    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;
  };
}
