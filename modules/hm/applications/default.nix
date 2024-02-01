{ config, lib, pkgs, ... }: {
  imports = [ ./calibre.nix ./discord.nix ./emacs.nix ];
}
