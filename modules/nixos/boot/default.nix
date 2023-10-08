{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./grub.nix
    ./plymouth.nix
  ];

  config = {
    boot.loader.efi.efiSysMountPoint = "/efi";
  };
}
