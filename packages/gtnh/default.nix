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
}
