{ config, lib, pkgs, ... }@args:
let
  cfg = config.nuisance.modules.nixos.services.minecraft;

  eulaFile = builtins.toFile "eula.txt" ''
    eula=true
  '';

  serverProperties = {
    op-permission-level = 2;
    allow-nether = true;
    level-name = "World";
    enable-query = false;
    allow-flight = true;
    announce-player-achievements = true;
    level-type = "rwg";
    force-gamemode = false;
    max-build-height = 256;
    spawn-npcs = true;
    white-list = true;
    spawn-animals = true;
    hardcore = false;
    snooper-enabled = true;
    online-mode = true;
    server-id = "unnamed";
    pvp = true;
    difficulty = 3;
    enable-command-block = true;
    gamemode = 0;
    player-idle-timeout = 0;
    max-players = 20;
    spawn-monsters = true;
    generate-structures = true;
    view-distance = 8;
    spawn-protection = 1;
    motd = "GT New Horizons 2.4.0";
  } // cfg.serverProperties // {
    server-port = cfg.serverPort;
    enable-rcon = cfg.enableRcon;
    rcon-port = cfg.rconPort;
    rcon-password = cfg.rconPassword;
  };

  serverPropertiesFile = pkgs.writeText "server.properties"
    (lib.generators.toINIWithGlobalSection { } {
      globalSection = serverProperties;
    });
in {
  options.nuisance.modules.nixos.services.minecraft = {
    enable = lib.mkOption {
      description = ''
        Whether to enable this module.
      '';
      type = lib.types.bool;
      default = false;
    };

    startOnBoot = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.nuisance.gtnh-server;
    };

    stateDirectory = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/minecraft";
    };

    serverProperties = lib.mkOption {
      type = with lib.types; attrsOf (oneOf [ bool int str ]);
      default = { };
    };

    serverPort = lib.mkOption {
      type = lib.types.port;
      default = 25565;
    };

    enableRcon = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    rconPort = lib.mkOption {
      type = lib.types.port;
      default = 25575;
    };

    rconPassword = lib.mkOption {
      type = lib.types.str;
      default = "";
    };

    maxMemory = lib.mkOption {
      type = lib.types.str;
      default = "4G";
    };

    minMemory = lib.mkOption {
      type = lib.types.str;
      default = "2G";
    };

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.minecraft = {
      description = "Minecraft service user";
      group = "minecraft";
      isSystemUser = true;
      createHome = true;
      home = cfg.stateDirectory;
      homeMode = "770";
    };

    users.groups.minecraft = { };

    systemd.sockets.minecraft = {
      bindsTo = [ "minecraft.service" ];
      socketConfig = {
        ListenFIFO = "/run/minecraft.stdin";
        SocketMode = "0660";
        SocketUser = "minecraft";
        SocketGroup = "minecraft";
        RemoveOnStop = true;
        FlushPending = true;
      };
    };

    systemd.services.minecraft = {
      description = "GT New Horizons Server service";
      wantedBy = if cfg.startOnBoot then [ "multi-user.target" ] else [ ];
      requires = [ "minecraft.socket" ];
      after = [ "network.target" "minecraft.socket" ];

      serviceConfig = {
        ExecStart =
          "${cfg.package}/bin/minecraft-start -Xms${cfg.minMemory} -Xmx${cfg.maxMemory}";
        ExecStop =
          "${cfg.package}/bin/minecraft-stop $MAINPID ${config.systemd.sockets.minecraft.socketConfig.ListenFIFO}";
        User = "minecraft";
        WorkingDirectory = cfg.stateDirectory;
        Restart = "always";

        StandardInput = "socket";
        StandardOutput = "journal";
        StandardError = "journal";
      };

      preStart = ''
        function overwrite {
          SOURCE="${cfg.package}/lib/minecraft/$1"
          DEST="$1"

          [[ -e "$DEST" ]] && rm -r "$DEST"
          cp -rTv --no-preserve mode "$SOURCE" "$DEST"
        }

        # eula
        ln -sf ${eulaFile} eula.txt

        if [[ ! -e .lock ]] then
          touch .lock

          [[ -e scripts ]] && rm -r scripts

          # configuration
          cp -bv --no-preserve mode --suffix .old ${serverPropertiesFile} ./server.properties

          # static files
          overwrite config
          overwrite mods
          overwrite libraries
          overwrite minecraft_server.1.7.10.jar
          overwrite forge-1.7.10-10.13.4.1614-1.7.10-universal.jar
          overwrite lwjgl3ify-forgePatches.jar
          overwrite java9args.txt
          overwrite server-icon.png
        fi
      '';
    };

    networking.firewall = lib.mkIf cfg.openFirewall {
      allowedTCPPorts = [ cfg.serverPort ];
      allowedUDPPorts = [ cfg.serverPort ]
        ++ lib.optionals cfg.enableRcon [ cfg.rconPort ];
    };
  };
}
