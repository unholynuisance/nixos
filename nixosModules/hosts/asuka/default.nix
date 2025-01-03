{ config, lib, pkgs, self, self', inputs, inputs', ... }: {
  imports = [ # #
    self.nixosModules.all
  ];

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

      services = { # #
        ssh.enable = true;
        avahi.enable = true;
      };

      shells = { # #
        zsh.enable = true;
      };

      virtualisation = { # #
        libvirt.enable = true;
      };

      gnome.enable = true;
      networkmanager.enable = true;
      pipewire.enable = true;
      rtkit.enable = true;

      steam = {
        enable = true;
        extraCompatPackages = with pkgs.nuisance; [ # #
          proton-ge-bin
          ge-proton8-16
          ge-proton8-25
        ];
      };

      xserver.enable = true;

      users.unholynuisance = {
        enable = true;
        shell = pkgs.zsh;
        extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
        modules = [{ nuisance.profiles.hm.asuka.enable = true; }];
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

    hardware.graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = with pkgs; [ amdvlk ];
      extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    };

    networking.useDHCP = lib.mkDefault true;

    environment.sessionVariables = { # #
      GSK_RENDERER = "ngl";
    };

    nuisance.modules.nixos.disko = {
      enable = true;
      config.devices = with self.lib.storage;
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
                  name = "data";
                  size = "100%FREE";
                  subvolumes = {
                    "?home" = { mountpoint = "/home"; };
                    "?home?unholynuisance" = {
                      mountpoint = "/home/unholynuisance";
                    };
                    "?var?lib?libvirt" = { # #
                      mountpoint = "/var/lib/libvirt";
                    };
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
