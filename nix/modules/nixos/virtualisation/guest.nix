{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.modules.nixos.virtualisation.guest;
in
{
  options.nuisance.modules.nixos.virtualisation.guest = {
    enable = lib.mkEnableOption "guest";
  };

  config = lib.mkIf cfg.enable {
    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;
  };
}
