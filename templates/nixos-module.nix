{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixos.name;
in
{
  options.modules.nixos.name = {
    enable = lib.mkEnableOption "name";
  };

  config = lib.mkIf cfg.enable { foo = "bar"; };
}
