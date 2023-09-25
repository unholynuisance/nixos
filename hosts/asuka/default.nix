{inputs}:
with inputs; let
  lib = nixpkgs.lib;
in
  nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {};
    modules = [
      home-manager.nixosModules.home-manager
      disko.nixosModules.disko

      ./../../configuration.nix
      ./../../modules

      (import ./storage/primary-master.nix {
        device = {
          name = "vda";
          path = "/dev/disk/by-id/ata-QEMU_DVD-ROM_QM00001";
        };
      })

      {config}: {
        config = {
          networking.hostName = "asuka";

          boot.initrd.availableKernelModules = ["ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk"];
          boot.initrd.kernelModules = [];
          boot.kernelModules = ["kvm-amd"];
          boot.extraModulePackages = [];

          networking.useDHCP = lib.mkDefault true;
          # nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

          boot.initrd.luks.devices.primary-rootvol.preLVM = lib.mkForce false;
          boot.initrd.luks.devices.primary-swapvol.preLVM = lib.mkForce false;
          boot.initrd.luks.devices.primary-homevol.preLVM = lib.mkForce false;

          fileSystems."/".device = lib.mkForce "/dev/disk/by-label/primary-root";
          fileSystems."/efi".device = lib.mkForce "/dev/disk/by-label/primary-efi";
          fileSystems."/boot".device = lib.mkForce "/dev/disk/by-label/primary-boot";
          fileSystems."/home".device = lib.mkForce "/dev/disk/by-label/primary-home";
        };
      }
    ];
  }
