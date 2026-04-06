{
  lib,
  self,
  inputs,
  ...
}:
{
  imports = [
    ./outputs.nix
    ./modules.nix
    ./shells.nix
  ];

  config.perSystem =
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = lib.attrsets.attrValues self.overlays;
        config.allowUnfree = true;
      };
    };
}
