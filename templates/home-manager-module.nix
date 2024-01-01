{ config, lib, pkgs, ... }@args:
let cfg = config.modules.hm.name;
in {
  options.modules.hm.name = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable { foo = "bar"; };
}
