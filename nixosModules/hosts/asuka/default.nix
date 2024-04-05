{ config, lib, pkgs, self, self', inputs, inputs', ... }@args: {
  imports = [ inputs.disko.nixosModules.disko self.nixosModules.all ];

  config = {
    networking.hostName = "asuka";

    nuisance.modules.nixos = {
      boot = {
        plymouth.enable = true;

        grub = {
          enable = true;
          resolution = "2560x1600";
        };
      };

      shells = { # #
        zsh.enable = true;
      };

      gnome.enable = true;
      guest.enable = true;
      networkmanager.enable = true;
      pipewire.enable = true;
      rtkit.enable = true;

      steam = {
        enable = true;
        extraCompatTools = with pkgs.nuisance; [ # #
          ge-proton8-16
          ge-proton8-25
        ];
      };

      libvirt.enable = true;
      xserver.enable = true;

      users.unholynuisance = {
        enable = true;
        shell = pkgs.zsh;
        extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
      };
    };

    boot.initrd.systemd.enable = true;
    boot.initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "thunderbolt"
      "usb_storage"
      "sd_mod"
      "rtsx_pci_sdmmc"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    hardware.enableAllFirmware = true;
    hardware.enableRedistributableFirmware = true;
    hardware.wirelessRegulatoryDatabase = true;

    hardware.opengl = {
      driSupport = true;
      driSupport32Bit = true;

      extraPackages = with pkgs; [ amdvlk driversi686Linux.amdvlk ];
    };

    networking.useDHCP = lib.mkDefault true;

    disko.devices = with self.lib.storage;
      mkDevices {
        disks = [
          (mkDisk {
            name = "nvme0n1";
            device =
              "/dev/disk/by-id/nvme-SKHynix_HFS001TEJ4X112N_4JC5N4835101A5L1A";
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
              (mkSwapVolume {
                size = "32G";
                encrypt = true;
                unlock = true;
              })
              (mkBtrfsVolume {
                name = "root";
                size = "128G";
                subvolumes = {
                  "?" = { mountpoint = "/"; };
                  "?nix" = { mountpoint = "/nix"; };
                  "?var?log" = { mountpoint = "/var/log"; };
                };
                encrypt = true;
                unlock = true;
              })
              (mkBtrfsVolume {
                name = "home";
                size = "100%FREE";
                subvolumes = {
                  "?" = { mountpoint = "/home"; };
                  "?unholynuisance" = { mountpoint = "/home/unholynuisance"; };
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
