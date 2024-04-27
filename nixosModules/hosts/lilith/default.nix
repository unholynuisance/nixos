{ config, lib, pkgs, self, self', inputs, inputs', ... }: {
  imports = [ # #
    self.nixosModules.all
  ];

  config = {
    networking.hostName = "lilith";

    nuisance.modules.nixos = {
      services = { # #
        ssh.enable = true;
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
        modules = [{ nuisance.profiles.hm.headless.enable = true; }];
      };
    };

    boot.loader.grub.enable = false;
    boot.loader.generic-extlinux-compatible.enable = true;
    boot.initrd.availableKernelModules = [ "xhci_pci" ];
    hardware.enableRedistributableFirmware = lib.mkDefault true;
    networking.useDHCP = lib.mkDefault true;

    nuisance.modules.nixos.disko = {
      enable = true;
      config.devices = with pkgs.lib.nuisance.storage;
        mkDevices {
          disks = [
            (mkDisk {
              name = "mmcblk1";
              device = "/dev/disk/by-id/mmc-USDU1_0x300b7c7e";
              partitions = [
                (mkEfiPartition { size = "128M"; })
                (mkBootPartition { size = "1G"; })
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
                (mkSwapVolume {
                  size = "8G";
                  encrypt = true;
                  unlock = true;
                })
                (mkBtrfsVolume {
                  name = "root";
                  size = "100%FREE";
                  subvolumes = {
                    "?" = { mountpoint = "/"; };
                    "?nix" = { mountpoint = "/nix"; };
                    "?var?log" = { mountpoint = "/var/log"; };
                  };
                  encrypt = true;
                  unlock = true;
                })
              ];
            })
          ];
        };
    };
  };
}
