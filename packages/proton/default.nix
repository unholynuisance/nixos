{ lib, stdenv, fetchzip, ... }: {
  proton-ge = stdenv.mkDerivation rec {
    pname = "proton-ge-custom";
    version = "GE-Proton8-25";

    src = fetchzip {
      url =
        "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${version}/${version}.tar.gz";
      sha256 = "sha256-IoClZ6hl2lsz9OGfFgnz7vEAGlSY2+1K2lDEEsJQOfU=";
    };

    installPhase = ''
      cp -r $src $out
    '';
  };
}
