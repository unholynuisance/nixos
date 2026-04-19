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
    ./devenv.nix
    ./configurations.nix
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

  config = {
    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
  };
}
