{ self, inputs }:
{
  lib = final: prev: {
    lib = prev.lib.extend (_final: _prev: { nuisance = self.lib; });
  };

  pkgs = final: prev: {
    nuisance = self.packages.${prev.stdenv.hostPlatform.system};
    master = inputs.nixpkgs-master.legacyPackages.${prev.stdenv.hostPlatform.system};
    release = inputs.nixpkgs-release.legacyPackages.${prev.stdenv.hostPlatform.system};
  };

  xkeyboard_config_patched = final: prev: {
    xkeyboard_config_patched = final.xkeyboard_config.overrideAttrs (_old: {
      src = inputs.xkeyboard-config-src;
    });
  };

  xwayland = _final: prev: {
    xwayland = prev.xwayland.overrideAttrs (old: {
      mesonFlags = old.mesonFlags ++ [
        "-Dxwayland_ei=socket"
      ];
    });
  };
}
