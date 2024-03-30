{ config, lib, pkgs, self, ... }: {
  imports = [ ];

  config = {
    virtualisation = rec {
      vmVariant = {
        virtualisation = {
          memorySize = 8 * 1024;
          cores = 4;
        };
      };

      vmVariantWithBootLoader = vmVariant;
    };
  };
}
