{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.nuisance.modules.hm.tools;
in
{
  imports = [

    ./direnv.nix
    ./git.nix
    ./nix.nix
    ./xdg.nix
  ];

  options = {
    nuisance.modules.hm.tools = {
      fd.enable = lib.mkEnableOption "fd";
      ripgrep.enable = lib.mkEnableOption "ripgrep";
      zip.enable = lib.mkEnableOption "zip";

      latex.enable = lib.mkEnableOption "latex";
    };
  };

  config = {
    home.packages =
      with pkgs;
      let
        inherit (lib.nuisance.utils) mkOptPackages optPackages;
      in
      (mkOptPackages [
        (optPackages cfg.fd.enable [ fd ])
        (optPackages cfg.ripgrep.enable [ ripgrep ])
        (optPackages cfg.zip.enable [ zip ])
        (optPackages cfg.latex.enable [ texlive.combined.scheme-full ])
      ]);
  };
}
