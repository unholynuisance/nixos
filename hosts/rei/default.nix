{
  config,
  lib,
  pkgs,
  self,
  home-manager,
  disko,
  ...
} @ args: {
  imports = [
    home-manager.nixosModules.home-manager
    disko.nixosModules.disko
    self.nixosModules.combined
  ];

  config = {
    networking.hostName = "rei";

    modules.nixos.boot.plymouth.enable = true;
    modules.nixos.gnome.enable = true;
    modules.nixos.grub.enable = true;
    modules.nixos.guest.enable = true;
    modules.nixos.home-manager.enable = true;
    modules.nixos.networkmanager.enable = true;
    modules.nixos.pipewire.enable = true;
    modules.nixos.rtkit.enable = true;
    modules.nixos.steam.enable = true;
    modules.nixos.libvirt.enable = true;
    modules.nixos.xserver.enable = true;

    modules.nixos.users.unholynuisance.enable = true;

    boot.initrd.systemd.enable = true;
    boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-amd"];
    boot.extraModulePackages = [];

    hardware.enableAllFirmware = true;
    hardware.enableRedistributableFirmware = true;
    hardware.wirelessRegulatoryDatabase = true;

    hardware.opengl = {
      driSupport = true;
      driSupport32Bit = true;

      extraPackages = with pkgs; [
        amdvlk
        driversi686Linux.amdvlk
      ];
    };

    networking.useDHCP = lib.mkDefault true;

    disko.devices = with self.lib.storage;
      mkDevices {
        disks = [
          (mkDisk {
            name = "nvme0n1";
            device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_2TB_S4J4NX0W704961W";
            partitions = [
              (mkEfiPartition {size = "128M";})
              (mkPhysicalVolumePartition {
                size = "100%";
                vg = "primary";
              })
            ];
          })
          # (mkDisk {
          #   name = "sda";
          #   device = "/dev/disk/by-id/ata-KINGSTON_SA400S37960G_50026B7282DD00AE";
          #   partitions = [
          #     (mkPhysicalVolumePartition {
          #       size = "100%";
          #       vg = "secondary";
          #     })
          #   ];
          # })
          # (mkDisk {
          #   name = "sdb";
          #   device = "/dev/disk/by-id/ata-KINGSTON_SA400S37960G_50026B76835CE2EE";
          #   partitions = [
          #     (mkPhysicalVolumePartition {
          #       size = "100%";
          #       vg = "secondary";
          #     })
          #   ];
          # })
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
              (mkBootVolume {size = "1G";})
              (mkSwapVolume {
                size = "32G";
                encrypt = true;
                unlock = true;
              })
              (mkBtrfsVolume {
                name = "root";
                size = "128G";
                subvolumes = {
                  "?" = {mountpoint = "/";};
                  "?var?log" = {mountpoint = "/var/log";};
                  "?nix" = {mountpoint = "/nix";};
                };
                encrypt = true;
                unlock = true;
              })
              (mkBtrfsVolume {
                name = "home";
                size = "256G";
                subvolumes = {
                  "?" = {mountpoint = "/home";};
                  "?unholynuisance" = {mountpoint = "/home/unholynuisance";};
                };
                encrypt = true;
                unlock = true;
              })
              (mkBtrfsVolume {
                name = "media";
                size = "100%FREE";
                subvolumes = {
                  "?unholynuisance?games" = {mountpoint = "/media/unholynuisance/games/primary";};
                  "?unholynuisance?vms" = {mountpoint = "/media/unholynuisance/vms/primary";};
                };
                encrypt = true;
                unlock = true;
              })
            ];
          })
          # (mkVolumeGroup {
          #   name = "secondary";
          #   volumes = [
          #     (mkBtrfsVolume {
          #       name = "media";
          #       size = "100%FREE";
          #       subvolumes = {
          #         "?unholynuisance?games" = {mountpoint = "/media/unholynuisance/games/secondary";};
          #         "?unholynuisance?vms" = {mountpoint = "/media/unholynuisance/vms/secondary";};
          #       };
          #       encrypt = true;
          #       unlock = true;
          #     })
          #   ];
          # })
          # (mkVolumeGroup {
          #   name = "tertiary";
          #   volumes = [
          #     (mkBtrfsVolume {
          #       name = "media";
          #       size = "100%FREE";
          #       subvolumes = {
          #         "?unholynuisance?games" = {mountpoint = "/media/unholynuisance/games/tertiary";};
          #         "?unholynuisance?vms" = {mountpoint = "/media/unholynuisance/vms/tertiary";};
          #       };
          #       encrypt = true;
          #       unlock = true;
          #     })
          #   ];
          # })
        ];
      };
  };
}
