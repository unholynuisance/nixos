{self, ...}: {
  lib = final: prev: {
    lib = prev.lib.extend (final: prev: {nuisance = self.lib;});
  };

  pkgs = final: prev: {
    nuisance = self.packages.${prev.system};
  };
}
