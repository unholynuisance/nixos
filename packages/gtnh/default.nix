{ pkgs, ... }:
let inherit (pkgs) callPackage;
in rec {
  gtnh-server = gtnh-server261;
  gtnh-client = gtnh-client261;

  gtnh-server261 = callPackage ./gtnh-server.nix {
    version = "2.6.1";
    hash = "sha256-DsfAy4Y1C4Fqe5SZ34D3OeUc6Gxv6L7S2HTuz9Vqt00=";
  };

  gtnh-client261 = callPackage ./gtnh-client.nix {
    version = "2.6.1";
    hash = "sha256-qVsSdYoFrCCNLxpsZ3JD9G+2VZzWmFQ6ysFQcyW6WBc=";
  };

  gtnh-server270-beta-2 = callPackage ./gtnh-server.nix {
    version = "2.7.0-beta-2";
    url =
      "https://downloads.gtnewhorizons.com/ServerPacks/betas/GT_New_Horizons_2.7.0-beta-2_Server_Java_17-21.zip";
    hash = "sha256-RTxPvRKeREq1+v9KRo3rSQugvdk/CEqeOKzOhYd/4Tk=";
  };

  gtnh-client270-beta-2 = callPackage ./gtnh-client.nix {
    version = "2.7.0-beta-2";
    url =
      "https://downloads.gtnewhorizons.com/Multi_mc_downloads/betas/GT_New_Horizons_2.7.0-beta-2_Java_17-21.zip";
    hash = "sha256-NayuYvC1yC5QaI1E4DhwkA69mYagtmn7bn9PjgVQRvQ=";
  };
}
