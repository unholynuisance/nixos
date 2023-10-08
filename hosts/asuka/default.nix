{
  config,
  lib,
  pkgs,
  nixosModules,
  home-manager,
  disko,
  ...
} @ args: {
  imports = [
    home-manager.nixosModules.home-manager
    disko.nixosModules.disko
    nixosModules

    (import ./storage/primary-master.nix {
      device = {
        name = "nvme0n1";
        path = "nvme-SKHynix_HFS001TEJ4X112N_4JC5N4835101A5L1A";
      };
    })
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
    modules.nixos.xserver.enable = true;

    modules.nixos.users.unholynuisance.enable = true;

    boot.initrd.systemd.enable = true;
    boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-amd"];
    boot.extraModulePackages = [];

    networking.useDHCP = lib.mkDefault true;


    fileSystems."/".device = lib.mkForce "/dev/disk/by-label/primary-root";
    fileSystems."/efi".device = lib.mkForce "/dev/disk/by-label/primary-efi";
    fileSystems."/boot".device = lib.mkForce "/dev/disk/by-label/primary-boot";
    fileSystems."/home".device = lib.mkForce "/dev/disk/by-label/primary-home";
  };
}
