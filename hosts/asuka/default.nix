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
    networking.hostName = "asuka";

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
            device = "/dev/disk/by-id/nvme-SKHynix_HFS001TEJ4X112N_4JC5N4835101A5L1A";
            partitions = [
              (mkEfiPartition {size = "128M";})
              (mkPhysicalVolumePartition {
                size = "100%";
                vg = "primary";
              })
            ];
          })
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
                  "?nix" = {mountpoint = "/nix";};
                  "?var?log" = {mountpoint = "/var/log";};
                };
                encrypt = true;
                unlock = true;
              })
              (mkBtrfsVolume {
                name = "home";
                size = "100%FREE";
                subvolumes = {
                  "?" = {mountpoint = "/home";};
                  "?unholynuisance" = {mountpoint = "/home/unholynuisance";};
                };
                encrypt = true;
                unlock = true;
              })
            ];
          })
        ];
      };
  };
}
