{ ... }:

{
  imports = [
    ./hardware.nix
  ];

  config = {
    networking.hostName = "shinji";
  };
}
