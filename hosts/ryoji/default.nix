{inputs}:
with inputs; let
  lib = nixpkgs.lib;
in
  nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {};
    modules = [
      "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"

      home-manager.nixosModules.home-manager

      ./../../modules/nixos

      ({
        config,
        lib,
        ...
      }: {
        config = {
          networking.hostName = "ryoji";

          boot.initrd.availableKernelModules = ["ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk"];
          boot.initrd.kernelModules = [];
          boot.kernelModules = ["kvm-amd"];
          boot.extraModulePackages = [];

          networking.useDHCP = lib.mkDefault true;
          nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        };
      })
    ];
  }
