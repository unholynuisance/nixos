{ config, self, inputs, ... }: {
  config.flake = {
    overlays = {
      lib = final: prev: { # #
        lib = prev.lib.extend (final: prev: { nuisance = self.lib; });
      };

      pkgs = final: prev: { # #
        nuisance = self.packages.${prev.system};
        master = inputs.nixpkgs-master.legacyPackages.${prev.system};
      };

      # electron = final: prev: { # #
      #   inherit (prev.master) electron electron_28;
      # };

      # teams = final: prev: { # #
      #   inherit (prev.master) teams-for-linux;
      # };

      xkeyboard_config_patched = (final: prev: {
        xkeyboard_config_patched = final.xkeyboard_config.overrideAttrs
          (old: { src = inputs.xkeyboard-config-src; });
      });
      };
    };
  };
}
