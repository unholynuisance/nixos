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

      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.nuisance.gtnh-client;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (prismlauncher.override {
        jdks = [
          # jdk25
          jdk21
          jdk17
          jdk8
        ];
      })
    ];

    home.activation =
      let
        path = "${config.home.homeDirectory}/.local/share/PrismLauncher/instances/gtnh-${cfg.instances.gtnh.package.version}";
      in
      {
        minecraft = ''
          if [[ ! -e ${path} ]] then
            mkdir -p ${path}
            cp -rTv --no-preserve mode ${cfg.instances.gtnh.package} ${path}

            pushd ${path}
            cp -rTv --no-preserve mode ${./instances/gtnh/.minecraft} .minecraft
            popd
          fi
        '';
      };
  };
}
