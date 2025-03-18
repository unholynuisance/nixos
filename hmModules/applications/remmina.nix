{
  config,
  lib,
  ...
}:
let
  cfg = config.nuisance.modules.hm.applications.remmina;
in
{
  options.nuisance.modules.hm.applications.remmina = {
    enable = lib.mkEnableOption "remmina";
  };

  config = lib.mkIf cfg.enable {
    services.remmina = {
      enable = true;
    };
  };
}
