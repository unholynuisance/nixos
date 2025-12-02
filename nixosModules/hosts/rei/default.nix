{
  config,
  lib,
  pkgs,
  self,
  ...
}:
{
  imports = [
    self.nixosModules.all
    ./storage.nix
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

      services = {
        ssh.enable = true;
        avahi.enable = true;
      };

      services.gtnh = {
        enable = true;
        package = pkgs.nuisance.gtnh-server280;
        viewDistance = 16;
      };

      gnome.enable = true;
      networkmanager.enable = true;
      pipewire.enable = true;
      rtkit.enable = true;
      shells.zsh.enable = true;

      programs = {
        wireshark.enable = true;
      };

      steam = {
        enable = true;
        extraCompatPackages = with pkgs.nuisance; [
          proton-ge-bin
          ge-proton8-16
          ge-proton8-25
        ];
      };

      xserver.enable = true;

      virtualisation = {
        podman.enable = true;
        libvirt.enable = true;
      };

      users.unholynuisance = {
        enable = true;
        shell = pkgs.zsh;
        extraGroups = [
          "wheel"
          "networkmanager"
          "libvirtd"
          "wireshark"
          "minecraft"
        ];
        modules = [ { nuisance.profiles.hm.rei.enable = true; } ];
      };
    };

    boot.initrd.systemd.enable = true;
    boot.initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "usbhid"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [
      "kvm-amd"
      "universal-pidff"
    ];
    boot.extraModulePackages = with config.boot.kernelPackages; [ universal-pidff ];

    environment.systemPackages = [ pkgs.release.boxflat ];
    services.udev.packages = [ pkgs.release.boxflat ];

    hardware.enableAllFirmware = true;
    hardware.enableRedistributableFirmware = true;
    hardware.wirelessRegulatoryDatabase = true;

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    networking.useDHCP = lib.mkDefault true;
  };
}
