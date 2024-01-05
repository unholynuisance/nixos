{ lib, stdenv, fetchzip, version, url, sha256, ... }:
stdenv.mkDerivation {
  pname = "ge-proton";
  inherit version;

  src = fetchzip { inherit url sha256; };

  installPhase = ''
    cp -r $src $out
  '';
}
