{ config, lib, pkgs, ... }:

{
  imports = [
    "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
  ];

  config = {
    boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    networking.useDHCP = lib.mkDefault true;
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    (import ./storage/primary-master.nix {
      device = { name = "vda"; path = "/dev/disk/by-id/ata-QEMU_DVD-ROM_QM00001"; };
    })
  };
}
