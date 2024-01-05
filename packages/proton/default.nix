{ callPackage, ... }: {
  ge-proton8-16 = callPackage ./ge-proton.nix rec {
    version = "GE-Proton8-16";
    url =
      "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${version}/${version}.tar.gz";
    sha256 = "sha256-75A0VCVdYkiMQ1duE9r2+DLBJzV02vUozoVLeo/TIWQ=";
  };

  ge-proton8-25 = callPackage ./ge-proton.nix rec {
    version = "GE-Proton8-25";
    url =
      "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${version}/${version}.tar.gz";
    sha256 = "sha256-IoClZ6hl2lsz9OGfFgnz7vEAGlSY2+1K2lDEEsJQOfU=";
  };
}
