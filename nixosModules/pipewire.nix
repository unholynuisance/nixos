{ config, lib, pkgs, ... }:
let cfg = config.nuisance.modules.nixos.pipewire;
in {
  options.nuisance.modules.nixos.pipewire = {
    enable = lib.mkEnableOption "pipewire";
  };

  config = lib.mkIf cfg.enable {
    sound.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # TODO find out where this is set to true
    hardware.pulseaudio.enable = false;
  };
}
