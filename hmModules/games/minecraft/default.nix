{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.modules.hm.games.minecraft;
in
{
  options.nuisance.modules.hm.games.minecraft = {
    enable = lib.mkEnableOption "minecraft";

    instances.gtnh = {
      enable = lib.mkEnableOption "gtnh";

      directory = lib.mkOption {
        type = lib.types.path;
        default = "${config.home.homeDirectory}/.local/share/PrismLauncher/instances/gtnh";
      };

      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.nuisance.gtnh-client;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ prismlauncher ];

    home.activation = {
      minecraft = ''
        function overwrite {
          SOURCE="${cfg.instances.gtnh.package}/$1"
          DEST="./$1"

          [[ -e "$DEST" ]] && rm -r "$DEST"
          cp -rTv --no-preserve mode "$SOURCE" "$DEST"
        }

        mkdir -p ${cfg.instances.gtnh.directory}
        pushd ${cfg.instances.gtnh.directory}
        if [[ ! -e .lock ]] then
          ln -sT ${cfg.instances.gtnh.package} .lock

          overwrite instance.cfg
          overwrite mmc-pack.json
          overwrite libraries
          overwrite patches

          mkdir -p .minecraft
          overwrite .minecraft/config
          overwrite .minecraft/mods
          overwrite .minecraft/resourcepacks
          overwrite .minecraft/serverutilities
          overwrite .minecraft/shaderpacks

          cp -rTv --no-preserve mode ${./instances/gtnh/.minecraft} .minecraft
        fi
        popd
      '';
    };
  };
}
