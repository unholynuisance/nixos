{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.modules.nixos.programs;
in
{
  options.nuisance.modules.nixos.programs = {
    wireshark.enable = lib.mkEnableOption "wireshark";
  };

  config = {

    programs.wireshark = {
      enable = cfg.wireshark.enable;
      package = with pkgs; wireshark-qt;
    };
  };
}
