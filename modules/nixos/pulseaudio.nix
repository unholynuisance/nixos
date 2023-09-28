{
  config,
  lib,
  pkgs,
  ...
} @ args: let
  name = "pulseaudio";
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
    hardware.pulseaudio.enable = true;
  };
}
