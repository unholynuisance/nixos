{ config, lib, pkgs, ... }: {
  imports = [ # #
    ./minecraft.nix
    ./ssh.nix
  ];
}
