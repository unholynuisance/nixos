{
  self,
  inputs,
  ...
}:
{
  config.flake = {
    overlays = {
      lib = final: prev: {
        lib = prev.lib.extend (final: prev: { nuisance = self.lib; });
      };

      pkgs = final: prev: {
        nuisance = self.packages.${prev.stdenv.hostPlatform.system};
        master = inputs.nixpkgs-master.legacyPackages.${prev.stdenv.hostPlatform.system};
        release = inputs.nixpkgs-release.legacyPackages.${prev.stdenv.hostPlatform.system};
      };

      xkeyboard_config_patched = final: prev: {
        xkeyboard_config_patched = final.xkeyboard_config.overrideAttrs (old: {
          src = inputs.xkeyboard-config-src;
          # TODO: remove when 2.46 is released.
          # reverts https://github.com/NixOS/nixpkgs/pull/429388
          patches = [ ];
        });
      };

      # TODO: remove once https://github.com/NixOS/nixpkgs/issues/485826 is resolved
      boost_build_failure_fix = final: prev: {
        krita = final.pkgs.release.krita;
        lager = final.pkgs.release.lager;
      };

      xwayland = final: prev: {
        xwayland = prev.xwayland.overrideAttrs (old: {
          mesonFlags = old.mesonFlags ++ [
            "-Dxwayland_ei=socket"
          ];
        });
      };
    };
  };
}
