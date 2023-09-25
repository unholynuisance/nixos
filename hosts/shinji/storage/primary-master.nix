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
          cryptrootvol = {
            size = "32G";
            content = {
              name = "primary-rootvol";
              type = "luks";
              extraFormatArgs = ["--label primary-cryptroot"];
              passwordFile = "/tmp/primary-cryptroot-password";
              initrdUnlock = true;
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
          };
          cryptswapvol = {
            size = "32G";
            content = {
              name = "primary-swapvol";
              type = "luks";
              extraFormatArgs = ["--label primary-cryptswap"];
              passwordFile = "/tmp/primary-cryptswap-password";
              initrdUnlock = true;
              content = {
                type = "swap";
              };
            };
          };
          crypthomevol = {
            size = "100%FREE";
            content = {
              name = "primary-homevol";
              type = "luks";
              extraFormatArgs = ["--label primary-crypthome"];
              passwordFile = "/tmp/primary-crypthome-password";
              initrdUnlock = true;
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
  };
}
