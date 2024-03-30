{ config, lib, pkgs, ... }@args:
let cfg = config.modules.hm.name;
in {
  options.modules.hm.name = { enable = lib.mkEnableOption "name"; };

  config = lib.mkIf cfg.enable { foo = "bar"; };
}
