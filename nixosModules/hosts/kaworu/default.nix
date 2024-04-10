{ config, lib, pkgs, self, self', inputs, inputs', ... }: {
  imports = [ # #
    self.nixosModules.all
  ];

  config = {
    networking.hostName = "kaworu";

    nuisance.modules.nixos = {
      boot = {
        plymouth.enable = true;
        grub.enable = true;
      };

      gnome.enable = true;
      networkmanager.enable = true;
      pipewire.enable = true;
      rtkit.enable = true;
      xserver.enable = true;

      virtualisation = { # #
        guest.enable = true;
      };

      users.unholynuisance = {
        enable = true;
        extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
        modules = [{ nuisance.profiles.hm.kaworu.enable = true; }];
      };
    };

    boot.initrd.systemd.enable = true;
    boot.initrd.availableKernelModules =
      [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ ];
    boot.extraModulePackages = [ config.boot.kernelPackages.rtl8821ce ];

    networking.useDHCP = lib.mkDefault true;

    nuisance.modules.nixos.disko = {
      enable = true;
      config.devices = with self.lib.storage;
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
  };
}
