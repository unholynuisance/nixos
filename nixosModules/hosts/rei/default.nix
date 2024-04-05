{ config, lib, pkgs, self, self', inputs, inputs', ... }@args: {
  imports = [ # #
    self.nixosModules.all
  ];

  config = {
    networking.hostName = "rei";

    nuisance.modules.nixos = {
      boot = {
        plymouth.enable = true;

        grub = {
          enable = true;
          resolution = "2560x1440";
        };
      };

      gnome.enable = true;
      networkmanager.enable = true;
      pipewire.enable = true;
      rtkit.enable = true;
      shells.zsh.enable = true;

      steam = {
        enable = true;
        extraCompatTools = with pkgs.nuisance; [ # #
          ge-proton8-16
          ge-proton8-25
        ];
      };

      libvirt.enable = true;
      xserver.enable = true;

      services.minecraft = {
        enable = true;
        enableRcon = true;
        openFirewall = true;
      };

      virtualisation = { podman.enable = true; };

      users.unholynuisance = {
        enable = true;
        shell = pkgs.zsh;
        extraGroups = [ "wheel" "networkmanager" "libvirtd" "minecraft" ];
      };
    };

    boot.initrd.systemd.enable = true;
    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    hardware.enableAllFirmware = true;
    hardware.enableRedistributableFirmware = true;
    hardware.wirelessRegulatoryDatabase = true;

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = { modesetting.enable = true; };

    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;

      extraPackages = with pkgs; [ amdvlk driversi686Linux.amdvlk ];
    };

    networking.useDHCP = lib.mkDefault true;

    nuisance.modules.nixos.disko = {
      enable = true;
      config.devices = with pkgs.lib.nuisance.storage;
        mkDevices {
          disks = [
            (mkDisk {
              name = "nvme0n1";
              device =
                "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_2TB_S4J4NX0W704961W";
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
              device =
                "/dev/disk/by-id/ata-KINGSTON_SA400S37960G_50026B7282DD00AE";
              partitions = [
                (mkPhysicalVolumePartition {
                  size = "100%";
                  vg = "secondary";
                })
              ];
            })
            (mkDisk {
              name = "sdb";
              device =
                "/dev/disk/by-id/ata-KINGSTON_SA400S37960G_50026B76835CE2EE";
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
                    "?" = { mountpoint = "/"; };
                    "?nix" = { mountpoint = "/nix"; };
                    "?var?log" = { mountpoint = "/var/log"; };
                  };
                  encrypt = true;
                  unlock = true;
                })
                (mkBtrfsVolume {
                  name = "home";
                  size = "256G";
                  subvolumes = {
                    "?" = { mountpoint = "/home"; };
                    "?unholynuisance" = {
                      mountpoint = "/home/unholynuisance";
                    };
                  };
                  encrypt = true;
                  unlock = true;
                })
                (mkBtrfsVolume {
                  name = "media";
                  size = "100%FREE";
                  subvolumes = {
                    "?unholynuisance?games" = {
                      mountpoint = "/media/unholynuisance/games/primary";
                    };
                    "?unholynuisance?vms" = {
                      mountpoint = "/media/unholynuisance/vms/primary";
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
                  name = "media";
                  size = "100%FREE";
                  subvolumes = {
                    "?unholynuisance?games" = { # #
                      mountpoint = "/media/unholynuisance/games/secondary";
                    };
                    "?unholynuisance?vms" = { # #
                      mountpoint = "/media/unholynuisance/vms/secondary";
                    };
                    "?var?lib?libvirt" = { # #
                      mountpoint = "/var/lib/libvirt";
                    };
                    "?var?lib?minecraft" = { # #
                      mountpoint = "/var/lib/minecraft";
                    };
                  };
                  encrypt = true;
                  unlock = true;
                })
                (mkBtrfsVolume {
                  name = "stash";
                  size = "32G";
                  subvolumes = { "?" = { }; };
                  encrypt = true;
                })
              ];
            })
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
  };
}
