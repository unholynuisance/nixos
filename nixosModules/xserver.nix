{ config, lib, pkgs, inputs, ... }:
let cfg = config.nuisance.modules.nixos.xserver;
in {
  options.nuisance.modules.nixos.xserver = {
    enable = lib.mkEnableOption "xserver";
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
