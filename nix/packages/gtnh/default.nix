{ pkgs, ... }:
let
  inherit (pkgs) callPackage;
in
rec {
  gtnh-server = gtnh-server280;
  gtnh-client = gtnh-client280;

  gtnh-server280 = callPackage ./gtnh-server.nix {
    version = "2.8.0";
    url = "http://downloads.gtnewhorizons.com/ServerPacks/GT_New_Horizons_2.8.0_Server_Java_17-25.zip";
    hash = "sha256-2hp4abBgrFHcWwl4GGepiIFJSLmsgPsbMv0ofhj+qLQ=";
  };

  gtnh-client280 = callPackage ./gtnh-client.nix {
    version = "2.8.0";
    url = "http://downloads.gtnewhorizons.com/Multi_mc_downloads/GT_New_Horizons_2.8.0_Java_17-25.zip";
    hash = "sha256-S+7qKDFSPW1A2VvVvMOWeryjoFayO5NFkNqKf7Ye/VM=";
  };

}
