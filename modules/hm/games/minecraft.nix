{ config, lib, pkgs, ... }@args:
let cfg = config.nuisance.modules.hm.games.minecraft;
in {
  options.nuisance.modules.hm.games.minecraft = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };

    instances.gtnh = {
      enable = lib.mkOption {
        description = ''
          Whether to enable this instance.
        '';
        type = lib.types.bool;
        default = false;
      };

      directory = lib.mkOption {
        type = lib.types.path;
        default =
          "${config.home.homeDirectory}/.local/share/PrismLauncher/instances/gtnh";
      };

      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.nuisance.gtnh-client;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ prismlauncher-qt5 ];

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
          touch .lock

          overwrite instance.cfg
          overwrite mmc-pack.json
          overwrite patches

          mkdir -p .minecraft
          overwrite .minecraft/config
          overwrite .minecraft/mods
          overwrite .minecraft/resourcepacks
          overwrite .minecraft/shaderpacks
          overwrite .minecraft/options.txt
          overwrite .minecraft/optionsof.txt
          overwrite .minecraft/optionsshaders.txt
        fi
        popd
      '';
    };
  };
}
