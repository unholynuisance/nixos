{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.modules.hm.tools.nix;
in
{
  options.nuisance.modules.hm.tools.nix = {
    enable = lib.mkEnableOption "nix";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [

      nixd
      nixfmt-rfc-style
    ];
  };
}
