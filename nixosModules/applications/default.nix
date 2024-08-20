{ config, lib, pkgs, ... }:
let cfg = config.nuisance.modules.nixos.applications;
in {
  options.nuisance.modules.nixos.applications = {
    wireshark.enable = lib.mkEnableOption "wireshark";
  };

  config = { # #
    programs.wireshark = {
      enable = cfg.wireshark.enable;
      package = with pkgs; wireshark-qt;
    };
  };
}
