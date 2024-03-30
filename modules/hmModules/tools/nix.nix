{ config, lib, pkgs, ... }@args:
let cfg = config.nuisance.modules.hm.tools.nix;
in {
  options.nuisance.modules.hm.tools.nix = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable { home.packages = with pkgs; [ nixd nixfmt ]; };
}
