{
  lib,
  self,
  inputs,
  withSystem,
  ...
}:
{
  config.flake = {
    lib = import "${self}/nix/lib" { inherit lib withSystem; };
    overlays = import "${self}/nix/overlays" { inherit self inputs; };
  };

  config.perSystem =
    {
      lib,
      pkgs,
      inputs',
      ...
    }:
    {
      packages = import "${self}/nix/packages" { inherit lib pkgs inputs'; };
    };
}
