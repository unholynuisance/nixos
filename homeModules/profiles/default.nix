{
  ...
}:
{
  imports = [
    # major profiles
    ./cli.nix
    ./graphical.nix

    # minor profiles
    ./gnome.nix
    ./games.nix

    # host profiles
    ./asuka.nix
    ./kaworu.nix
    ./rei.nix
    ./yui.nix
  ];
}
