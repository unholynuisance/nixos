{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.modules.nixos.boot.plymouth;
in
{
  options.nuisance.modules.nixos.boot.plymouth = {
    enable = lib.mkEnableOption "plymouth";
  };

  config = lib.mkIf cfg.enable {
    boot.plymouth.enable = true;
    boot.kernelParams = [ "quiet" ];
  };
}
