{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nuisance.modules.nixos.services.gtnh;
in
{
  options.nuisance.modules.nixos.services.gtnh = {
    enable = lib.mkEnableOption "gtnh";

    package = lib.mkOption {
      type = lib.types.package;
      # FIXME: don't import pkgs in flake.nix
      # default = pkgs.nuisance.gtnh-server280;
    };

    whitelist = lib.mkOption {
      type = lib.types.str;
      default = ''unholynuisance'';
    };

    ops = lib.mkOption {
      type = lib.types.str;
      default = ''unholynuisance'';
    };

    serverPort = lib.mkOption {
      type = lib.types.port;
      default = 25565;
    };

    memory = lib.mkOption {
      type = lib.types.str;
      default = "8G";
    };

    viewDistance = lib.mkOption {
      type = lib.types.int;
      default = 8;
    };

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    nuisance.modules.nixos.virtualisation.podman.enable = true;

    users = {
      users.minecraft = {
        description = "Minecraft service user";
        group = "minecraft";
        isSystemUser = true;
        createHome = true;
        home = "/var/lib/minecraft";
        homeMode = "770";
        subGidRanges = [
          {
            startGid = 200000;
            count = 65536;
          }
        ];
        subUidRanges = [
          {
            startUid = 200000;
            count = 65536;
          }
        ];
      };
      groups.minecraft = { };
    };

    virtualisation.oci-containers = {
      containers = {
        gtnh-solo =
          let
            name = "gtnh-solo";
            stateDirectory = "${config.users.users.minecraft.home}/${name}";
          in
          {
            serviceName = "podman@${name}";
            image = "itzg/minecraft-server:latest";
            ports = [ "127.0.0.1:${toString cfg.serverPort}:25565" ];

            extraOptions = [
              "-i"
              "-t"
            ];

            volumes = [
              "${stateDirectory}:/data"
              "${cfg.package}:/server-files/${cfg.package.name}.zip:ro"
              "${./scripts/prepare-update.sh}:/usr/local/bin/prepare-update:ro"
              "${./scripts/clean-update.sh}:/usr/local/bin/clean-update:ro"
            ];

            environment = {
              MOTD = "GT:New Horizons";

              GENERIC_PACK = "/server-files/${cfg.package.name}.zip";
              SKIP_GENERIC_PACK_UPDATE_CHECK = "true";

              TYPE = "CUSTOM";
              CUSTOM_SERVER = "lwjgl3ify-forgePatches.jar";
              JVM_OPTS = "-Dfml.readTimeout=180 @java9args.txt";

              EULA = "TRUE";
              DUMP_SERVER_PROPERTIES = "TRUE";
              CREATE_CONSOLE_IN_PIPE = "TRUE";

              SPAWN_PROTECTION = "0";
              MODE = "0";
              DIFFICULTY = "hard";
              LEVEL_TYPE = "rwg";
              ALLOW_FLIGHT = "TRUE";
              ENABLE_COMMAND_BLOCK = "TRUE";

              VIEW_DISTANCE = "${toString cfg.viewDistance}";
              MEMORY = cfg.memory;
              WHITELIST = cfg.whitelist;
              OPS = cfg.ops;
            };

            autoStart = false;

            # podman = {
            #   user = "minecraft";
            # };
          };
      };
    };

    networking.firewall = lib.mkIf cfg.openFirewall {
      allowedTCPPorts = [ cfg.serverPort ];
    };
  };
}
