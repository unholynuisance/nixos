{ ... }:

{
  imports = [
    ./hardware.nix
  ];

  config = {
    networking.hostName = "asuka";
  };
}
