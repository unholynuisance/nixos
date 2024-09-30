{ config, lib, pkgs, self, self', inputs, inputs', ... }: {
  config = {
    containers.gtnh-solo = {
      config = { config, self, ... }: {
        imports = [ self.nixosModules.all ];
        config = {
          nuisance.modules.nixos.services.minecraft = {
            enable = true;
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
  };
}
