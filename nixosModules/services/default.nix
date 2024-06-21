{ config, lib, pkgs, ... }: {
  imports = [ # #
    ./avahi.nix
    ./minecraft.nix
    ./ssh.nix
  ];
}
