{ config, lib, pkgs, ... }@args:
let cfg = config.nuisance.modules.hm.applications.discord;
in {
  options.nuisance.modules.hm.applications.discord = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ discord ];

    home.activation = {
      discord = ''
        file="''${HOME}/.config/discord/settings.json"
        if [[ ! -f "''${file}" ]]
        then
          mkdir -p "$(dirname "''${file}")"
          echo '{ "SKIP_HOST_UPDATE": true, "OPEN_ON_STARTUP": false }' > "''${file}"
        fi
      '';
    };
  };
}
