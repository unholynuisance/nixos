{device, ...}: {
  disko.devices = {
    disk = {
      ${device.name} = {
        type = "disk";
        device = device.path;
        content = {
          type = "gpt";
          partitions = {
            efi = {
              label = "${device.name}-primary-efi";
              size = "128M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/efi";
                extraArgs = ["-n primary-efi"];
              };
            };
            lvm = {
              label = "${device.name}-primary-lvm";
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "primary";
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      primary = {
        type = "lvm_vg";
        lvs = {
          bootvol = {
            size = "1G";
            content = {
              type = "btrfs";
              extraArgs = ["--label primary-boot"];
              subvolumes = {
                "@" = {
                  mountpoint = "/boot";
                };
              };
            };
          };
          rootvol = {
            size = "32G";
            content = {
              type = "btrfs";
              extraArgs = ["--label primary-root"];
              subvolumes = {
                "@" = {
                  mountpoint = "/";
                };
              };
            };
          };
          swapvol = {
            size = "4G";
            content = {
              type = "swap";
            };
          };
          homevol = {
            size = "100%FREE";
            content = {
              type = "btrfs";
              extraArgs = ["--label primary-home"];
              subvolumes = {
                "@" = {
                  mountpoint = "/home";
                };
              };
            };
          };
        };
      };
    };
  };
}
