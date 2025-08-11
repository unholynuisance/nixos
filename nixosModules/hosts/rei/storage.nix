{
  pkgs,
  ...
}:
{
  config = {
    nuisance.modules.nixos.disko = {
      enable = true;
      config.devices =
        with pkgs.lib.nuisance.storage;
        mkDevices {
          disks = [
            (mkDisk {
              name = "nvme0n1";
              device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_2TB_S4J4NX0W704961W";
              partitions = [
                (mkEfiPartition { size = "128M"; })
                (mkPhysicalVolumePartition {
                  size = "100%";
                  vg = "primary";
                })
              ];
            })
            (mkDisk {
              name = "sda";
              device = "/dev/disk/by-id/ata-KINGSTON_SA400S37960G_50026B7282DD00AE";
              partitions = [
                (mkPhysicalVolumePartition {
                  size = "100%";
                  vg = "secondary";
                })
              ];
            })
            (mkDisk {
              name = "sdb";
              device = "/dev/disk/by-id/ata-KINGSTON_SA400S37960G_50026B76835CE2EE";
              partitions = [
                (mkPhysicalVolumePartition {
                  size = "100%";
                  vg = "secondary";
                })
              ];
            })
            # (mkDisk {
            #   name = "sdd";
            #   device = "/dev/disk/by-id/ata-ST2000DM008-2FR102_ZFL4EW68";
            #   partitions = [
            #     (mkPhysicalVolumePartition {
            #       size = "100%";
            #       vg = "tertiary";
            #     })
            #   ];
            # })
            # (mkDisk {
            #   name = "sdc";
            #   device = "/dev/disk/by-id/ata-ST2000DM008-2UB102_WK30M5VB";
            #   partitions = [
            #     (mkPhysicalVolumePartition {
            #       size = "100%";
            #       vg = "tertiary";
            #     })
            #   ];
            # })
          ];
          volumeGroups = [
            (mkVolumeGroup {
              name = "primary";
              volumes = [
                (mkBootVolume { size = "1G"; })
                (mkSwapVolume {
                  size = "32G";
                  encrypt = true;
                  unlock = true;
                })
                (mkBtrfsVolume {
                  name = "root";
                  size = "128G";
                  subvolumes = {
                    "?" = {
                      mountpoint = "/";
                    };
                    "?nix" = {
                      mountpoint = "/nix";
                    };
                    "?var?log" = {
                      mountpoint = "/var/log";
                    };
                  };
                  encrypt = true;
                  unlock = true;
                })
                (mkBtrfsVolume {
                  name = "data";
                  size = "100%FREE";
                  subvolumes = {
                    "?home" = {

                      mountpoint = "/home";
                    };
                    "?home?unholynuisance" = {

                      mountpoint = "/home/unholynuisance";
                    };
                    "?data?unholynuisance?games" = {
                      mountpoint = "/data/unholynuisance/games/primary";
                    };
                    "?data?unholynuisance?vms" = {
                      mountpoint = "/data/unholynuisance/vms/primary";
                    };
                  };
                  encrypt = true;
                  unlock = true;
                })
              ];
            })
            (mkVolumeGroup {
              name = "secondary";
              volumes = [
                (mkBtrfsVolume {
                  name = "data";
                  size = "100%FREE";
                  subvolumes = {
                    "?data?unholynuisance?games" = {

                      mountpoint = "/data/unholynuisance/games/secondary";
                    };
                    "?data?unholynuisance?vms" = {

                      mountpoint = "/data/unholynuisance/vms/secondary";
                    };
                    "?var?lib?libvirt" = {

                      mountpoint = "/var/lib/libvirt";
                    };
                    "?var?lib?minecraft" = {

                      mountpoint = "/var/lib/minecraft";
                    };
                  };
                  encrypt = true;
                  unlock = true;
                })
                (mkBtrfsVolume {
                  name = "stash";
                  size = "32G";
                  subvolumes = {
                    "?" = { };
                  };
                  encrypt = true;
                })
              ];
            })
            # (mkVolumeGroup {
            #   name = "tertiary";
            #   volumes = [
            #     (mkBtrfsVolume {
            #       name = "data";
            #       size = "100%FREE";
            #       subvolumes = {
            #         "?unholynuisance?games" = {mountpoint = "/data/unholynuisance/games/tertiary";};
            #         "?unholynuisance?vms" = {mountpoint = "/data/unholynuisance/vms/tertiary";};
            #       };
            #       encrypt = true;
            #       unlock = true;
            #     })
            #   ];
            # })
          ];
        };
    };
  };
}
