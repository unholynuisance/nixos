{ config, lib, pkgs, inputs, ... }@args:
let cfg = config.nuisance.modules.nixos.xserver;
in {
  options.nuisance.modules.nixos.xserver = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [
      (final: prev: {
        xkeyboard_config = prev.xkeyboard_config.overrideAttrs
          (old: { src = inputs.xkeyboard-config-src; });
      })
    ];

    services.xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";

      excludePackages = with pkgs; [ xterm ];
    };
  };
}
