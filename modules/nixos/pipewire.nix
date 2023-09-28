{
  config,
  lib,
  pkgs,
  ...
} @ args: let
  name = "pipewire";
  cfg = config.modules.nixos.${name};
in {
  options.modules.nixos.${name} = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
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
