{ config, pkgs, ... }:
{
  config = {
    boot.loader.grub = {
      enable = true;
    };
  };
}
