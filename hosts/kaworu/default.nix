{
  config,
  lib,
  pkgs,
  self,
  home-manager,
  disko,
  ...
} @ args: {
  imports = [
    home-manager.nixosModules.home-manager
    disko.nixosModules.disko
    self.nixosModules.combined

    (import ./storage/primary-master.nix {
      device = {
        name = "vda";
        path = "ata-QEMU_DVD-ROM_QM00001";
      };
    })
  ];

  config = {
    networking.hostName = "kaworu";

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
    boot.initrd.availableKernelModules = ["ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = [];
    boot.extraModulePackages = [config.boot.kernelPackages.rtl8821ce];

    networking.useDHCP = lib.mkDefault true;

    security.tpm2 = {
      enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };

    fileSystems."/".device = lib.mkForce "/dev/disk/by-label/primary-root";
    fileSystems."/efi".device = lib.mkForce "/dev/disk/by-label/primary-efi";
    fileSystems."/boot".device = lib.mkForce "/dev/disk/by-label/primary-boot";
    fileSystems."/home".device = lib.mkForce "/dev/disk/by-label/primary-home";
  };
}
