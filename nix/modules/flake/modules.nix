{
  self,
  ...
}:
{
  config.flake = {
    nixosModules = rec {
      default = all;
      all = import "${self}/nix/modules/nixos";

      rei = import "${self}/nix/modules/nixos/hosts/rei";
      asuka = import "${self}/nix/modules/nixos/hosts/asuka";
      kaworu = import "${self}/nix/modules/nixos/hosts/kaworu";
      ryoji = import "${self}/nix/modules/nixos/hosts/ryoji";
      yui = import "${self}/nix/modules/nixos/hosts/yui";
    };

    homeModules = rec {
      default = all;
      all = import "${self}/nix/modules/home";

      unholynuisance = import "${self}/nix/modules/home/users/unholynuisance";
    };
  };
}
