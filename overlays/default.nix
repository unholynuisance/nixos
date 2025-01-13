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

      tree-sitter-grammars = final: prev: {
        tree-sitter-grammars = prev.tree-sitter-grammars // {
          tree-sitter-rust =
            prev.tree-sitter-grammars.tree-sitter-rust.overrideAttrs (_: {
              nativeBuildInputs = [ final.nodejs final.tree-sitter ];
              configurePhase = ''
                tree-sitter generate --abi 13 src/grammar.json
              '';
            });

          tree-sitter-cpp =
            prev.tree-sitter-grammars.tree-sitter-cpp.overrideAttrs (_: {
              nativeBuildInputs = [ final.nodejs final.tree-sitter ];
              configurePhase = ''
                tree-sitter generate --abi 13 src/grammar.json
              '';
            });
        };
      };
    };
  };
}
