{ stdenv, version, hash, jdk ? jdk21, jdk21, fetchzip, unzip }:
let
  src = fetchzip {
    inherit hash;
    url =
      "https://downloads.gtnewhorizons.com/Multi_mc_downloads/GT_New_Horizons_${version}_Java_17-21.zip";
    stripRoot = false;
  };

in stdenv.mkDerivation {
  inherit src version;
  pname = "gtnh-client";

  nativeBuildInputs = [ unzip ];

  installPhase = ''
    cp -rTv --no-preserve mode "$src/GT New Horizons ${version}" $out
    echo "JavaPath=${jdk}/bin/java" >> $out/instance.cfg

    cp -rTv ${./resources/resourcepacks} $out/.minecraft/resourcepacks
    cp -rTv ${./resources/shaderpacks} $out/.minecraft/shaderpacks
  '';
}
