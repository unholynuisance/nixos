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
    networking.hostName = "kaworu";

    modules.nixos.boot.plymouth.enable = true;
    modules.nixos.gnome.enable = true;
    modules.nixos.grub.enable = true;
    modules.nixos.guest.enable = true;
    modules.nixos.home-manager.enable = true;
    modules.nixos.networkmanager.enable = true;
    modules.nixos.pipewire.enable = true;
    modules.nixos.rtkit.enable = true;
    modules.nixos.xserver.enable = true;

    modules.nixos.users.unholynuisance.enable = true;

    boot.initrd.systemd.enable = true;
    boot.initrd.availableKernelModules = ["ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = [];
    boot.extraModulePackages = [config.boot.kernelPackages.rtl8821ce];

    networking.useDHCP = lib.mkDefault true;

    disko.devices = with self.lib.storage;
      mkDevices {
        disks = [
          (mkDisk {
            name = "nvme0n1";
            device = "/dev/disk/by-id/ata-QEMU_DVD-ROM_QM00001";
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
                size = "4G";
              })
              (mkBtrfsVolume {
                name = "root";
                size = "100%FREE";
                subvolumes = {
                  "?" = {mountpoint = "/";};
                  "?nix" = {mountpoint = "/nix";};
                  "?var?log" = {mountpoint = "/var/log";};
                  "?home?unholynuisance" = {mountpoint = "/home/unholynuisance";};
                };
              })
            ];
          })
        ];
      };
  };
}
