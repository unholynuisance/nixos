{ config, lib, pkgs, self, home-manager, disko, ... }@args: {
  imports = [
    home-manager.nixosModules.home-manager
    disko.nixosModules.disko
    self.nixosModules.combined
  ];

  config = {
    networking.hostName = "kaworu";

    nuisance.modules.nixos = {
      boot = {
        plymouth.enable = true;
        grub.enable = true;
      };

      gnome.enable = true;
      guest.enable = true;
      home-manager.enable = true;
      networkmanager.enable = true;
      pipewire.enable = true;
      rtkit.enable = true;
      xserver.enable = true;

      users.unholynuisance = {
        enable = true;
        extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
      };
    };

    boot.initrd.systemd.enable = true;
    boot.initrd.availableKernelModules =
      [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ ];
    boot.extraModulePackages = [ config.boot.kernelPackages.rtl8821ce ];

    networking.useDHCP = lib.mkDefault true;

    disko.devices = with self.lib.storage;
      mkDevices {
        disks = [
          (mkDisk {
            name = "nvme0n1";
            device = "/dev/disk/by-id/ata-QEMU_DVD-ROM_QM00001";
            partitions = [
              (mkEfiPartition { size = "128M"; })
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
              (mkBootVolume { size = "1G"; })
              (mkSwapVolume { size = "4G"; })
              (mkBtrfsVolume {
                name = "root";
                size = "100%FREE";
                subvolumes = {
                  "?" = { mountpoint = "/"; };
                  "?nix" = { mountpoint = "/nix"; };
                  "?var?log" = { mountpoint = "/var/log"; };
                  "?home?unholynuisance" = {
                    mountpoint = "/home/unholynuisance";
                  };
                };
              })
            ];
          })
        ];
      };
  };
}
