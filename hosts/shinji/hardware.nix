{ config, lib, pkgs, ... }:

{
  imports = [
    "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
  ];

  config = {
    boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ config.boot.kernelPackages.rtl8821ce ];

    networking.useDHCP = lib.mkDefault true;
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    security.tpm2 = {
      enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };

    boot.initrd.luks.devices.primary-rootvol.preLVM = lib.mkForce false;
    boot.initrd.luks.devices.primary-swapvol.preLVM = lib.mkForce false;
    boot.initrd.luks.devices.primary-homevol.preLVM = lib.mkForce false;

    fileSystems."/".device = lib.mkForce "/dev/disk/by-label/primary-root";
    fileSystems."/efi".device = lib.mkForce "/dev/disk/by-label/primary-efi";
    fileSystems."/boot".device = lib.mkForce "/dev/disk/by-label/primary-boot";
    fileSystems."/home".device = lib.mkForce "/dev/disk/by-label/primary-home";

    disko.devices = (import ./storage/primary-master.nix {
      device = { name = "sda"; path = "/dev/sda"; };
    }).disko.devices;
  };
}
