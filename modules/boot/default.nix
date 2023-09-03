{ config, pkgs, ... }:
{
  imports = [
    ./grub.nix
  ];

  config = {
    boot.loader.efi.efiSysMountPoint = "/efi";
  };
}
