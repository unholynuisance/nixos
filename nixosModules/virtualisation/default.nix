{ config, lib, pkgs, ... }: {
  imports = [ # #
    ./guest.nix
    ./libvirt.nix
    ./podman.nix
  ];

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
