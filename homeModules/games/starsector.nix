{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.modules.hm.games.starsector;

  resolution = "${(builtins.toString cfg.resolution.x)}x${(builtins.toString cfg.resolution.y)}";
in
{
  options.nuisance.modules.hm.games.starsector = {
    enable = lib.mkEnableOption "starsector";

    resolution = lib.mkOption {
      type = lib.types.nullOr (lib.types.attrsOf lib.types.ints.unsigned);
      default = null;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (starsector.overrideAttrs (prev: {
        postPatch =
          prev.postPatch
          + (lib.optionalString (cfg.resolution != null) ''
            substituteInPlace data/config/settings.json \
              --replace-fail \
              '#"resolutionOverride":' \
              '"resolutionOverride": "${resolution}", # '
          '');
      }))
    ];
  };
}
