{ config, lib, pkgs, ... }:
let cfg = config.nuisance.modules.nixos.pulseaudio;
in {
  options.nuisance.modules.nixos.pulseaudio = {
    enable = lib.mkEnableOption "pulseaudio";
  };

  config = lib.mkIf cfg.enable {
    sound.enable = true;
    hardware.pulseaudio.enable = true;
  };
}
