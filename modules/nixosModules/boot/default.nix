{ config, pkgs, ... }: {
  imports = [ ./grub.nix ./plymouth.nix ];

  config = {
    boot.loader.efi.efiSysMountPoint = "/efi";

    zramSwap = { enable = true; };

    boot.tmp = {
      useTmpfs = true;
      tmpfsSize = "100%";
    };
  };
}
