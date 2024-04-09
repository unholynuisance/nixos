{ config, lib, pkgs, ... }:
let cfg = config.nuisance.modules.hm.tools;
in {
  imports = [ # #
    ./direnv.nix
    ./git.nix
    ./nix.nix
  ];

  options = {
    nuisance.modules.hm.tools = {
      fd.enable = lib.mkEnableOption "fd";
      ripgrep.enable = lib.mkEnableOption "ripgrep";
      zip.enable = lib.mkEnableOption "zip";

      c.enable = lib.mkEnableOption "c";
      perl.enable = lib.mkEnableOption "perl";
      latex.enable = lib.mkEnableOption "latex";

      hunspell.enable = lib.mkEnableOption "hunspell";

      xdg-launch.enable = lib.mkEnableOption "xdg-launch";
    };
  };

  config = {
    home.packages = with pkgs;
      [ ] ++ (lib.optionals cfg.fd.enable [ # #
        fd
      ]) ++ (lib.optionals cfg.ripgrep.enable [ # #
        ripgrep
      ]) ++ (lib.optionals cfg.zip.enable [ # #
        zip
        unzip
      ]) ++ (lib.optionals cfg.c.enable [ # #
        gcc
        gnumake
        cmake
        libtool
      ]) ++ (lib.optionals cfg.perl.enable [ # #
        perl
      ]) ++ (lib.optionals cfg.latex.enable [ # #
        texlive.combined.scheme-full
      ]) ++ (lib.optionals cfg.hunspell.enable [ # #
        hunspell
        hunspellDicts.uk-ua
        hunspellDicts.en-us-large
      ]) ++ (lib.optionals cfg.xdg-launch.enable [ # #
        xdg-launch
      ]);
  };
}
