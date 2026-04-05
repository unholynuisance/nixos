{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.modules.nixos.services.ssh;
in
{
  options.nuisance.modules.nixos.services.ssh = {
    enable = lib.mkEnableOption "ssh";
  };

  config = {
    services.openssh = {

      enable = true;
    };
  };
}
