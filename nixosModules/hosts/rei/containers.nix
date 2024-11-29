{ config, lib, pkgs, self, self', inputs, inputs', ... }: {
  config = {
    containers.gtnh-valentine = {
      config = { config, self, ... }: {
        imports = [ self.nixosModules.all ];
        config = {
          nuisance.modules.nixos.services.minecraft = {
            enable = true;
            package = pkgs.nuisance.gtnh-server270-beta-2;
            autoStart = true;

            serverPort = 25565;
            rconPort = 25575;

            openFirewall = true;
            enableRcon = true;
          };
        };
      };

      bindMounts = {
        "/var/lib/minecraft" = {
          hostPath = "/var/lib/minecraft/gtnh-valentine";
          isReadOnly = false;
        };
      };

      autoStart = false;

      specialArgs = { inherit self self' inputs inputs'; };
    };

    containers.gtnh-solo = {
      config = { config, self, ... }: {
        imports = [ self.nixosModules.all ];
        config = {
          nuisance.modules.nixos.services.minecraft = {
            enable = true;
            package = pkgs.nuisance.gtnh-server270-beta-2;
            autoStart = true;

            serverPort = 25665;
            rconPort = 25675;

            openFirewall = true;
            enableRcon = true;
          };
        };
      };

      bindMounts = {
        "/var/lib/minecraft" = {
          hostPath = "/var/lib/minecraft/gtnh-solo";
          isReadOnly = false;
        };
      };

      autoStart = false;

      specialArgs = { inherit self self' inputs inputs'; };
    };

    containers.gtnh-coop = {
      config = { config, self, ... }: {
        imports = [ self.nixosModules.all ];
        config = {
          nuisance.modules.nixos.services.minecraft = {
            enable = true;
            package = pkgs.nuisance.gtnh-server270-beta-2;
            autoStart = true;

            serverPort = 25765;
            rconPort = 25775;

            openFirewall = true;
            enableRcon = true;
          };
        };
      };

      bindMounts = {
        "/var/lib/minecraft" = {
          hostPath = "/var/lib/minecraft/gtnh-coop";
          isReadOnly = false;
        };
      };

      autoStart = false;

      specialArgs = { inherit self self' inputs inputs'; };
    };

    networking.firewall = {
      allowedTCPPorts = [ 25565 25765 ];
      allowedUDPPorts = [ 25565 25765 ];
    };
  };
}
