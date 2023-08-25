{ device, ... }:

{
  disko.devices = {
    disk.primary = {
      type = "disk";
      device = device;
      content = {
        type = "gpt";
        partitions = {
          efi = {
            label = "primary-efi";
            size = "128M";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/efi";
              extraArgs = [ "-n primary-efi" ];
            };
          };
          lvm = {
            label = "primary-lvm";
            size = "100%";
            content = {
              type = "lvm_pv";
              vg = "primary";
            };
          };
        };
      };
    };
    lvm_vg = {
      primary = {
        type = "lvm_vg";
        name = "primary";
        lvs = {
          bootvol = {
            name = "bootvol";
            size = "1G";
            content = {
              type = "btrfs";
              extraArgs = [ "--label primary-boot" ];
              subvolumes = {
                "@" = {
                  mountpoint = "/boot";
                };
              };
            };
          };
          cryptrootvol = {
            name = "cryptrootvol";
            size = "16G";
            content = {
              name = "primary-rootvol";
              type = "luks";
              content = {
                type = "btrfs";
                mountpoint = "/";
                extraArgs = [ "--label primary-root" ];
              };
            };
          };
          crypthomevol = {
            name = "crypthomevol";
            size = "100%FREE";
            content = {
              name = "primary-homevol";
              type = "luks";
              content = {
                type = "btrfs";
                mountpoint = "/home";
                extraArgs = [ "--label primary-home" ];
              };
            };
          };
          cryptswapvol = {
            name = "cryptswapvol";
            size = "4G";
            content = {
              name = "primary-swapvol";
              type = "luks";
              content = {
                type = "swap";
              };
            };
          };
        };
      };
    };
  };
}
