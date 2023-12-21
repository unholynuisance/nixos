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
    boot.tmp = {
      useTmpfs = true;
      tmpfsSize = "75%";
    };
  };
}
