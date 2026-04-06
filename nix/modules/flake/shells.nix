{
  inputs,
  ...
}:
{
  imports = [
    inputs.devenv.flakeModule
    inputs.treefmt-nix.flakeModule
  ];

  config.perSystem =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      config = with pkgs; {
        devenv.shells.default = {
          packages = [ config.treefmt.build.wrapper ] ++ lib.attrValues config.treefmt.build.programs;

          languages = {
            nix = {
              enable = true;
              lsp.package = nixd;
            };
          };

          containers = lib.mkForce { };
        };

        treefmt.programs = {
          nixfmt.enable = true;
        };
      };
    };
}
