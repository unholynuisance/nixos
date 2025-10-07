{
  stdenv,
  version,
  url ? "https://downloads.gtnewhorizons.com/Multi_mc_downloads/GT_New_Horizons_${version}_Java_17-21.zip",
  hash,
  fetchurl,
  fetchzip,
  unzip,
}:
let
  src = fetchzip {
    inherit url hash;
    stripRoot = false;
  };

  foamfix = fetchurl {
    url = "https://mediafilez.forgecdn.net/files/4473/363/FoamFix-1.7.10-universal-1.0.4.jar";
    hash = "sha256-PIKmAUnwJNmgLNWC/9Sa7jbbojlK8wZeBU2Oa1Nk08Y=";
  };

  matmos = fetchurl {
    url = "https://mediafilez.forgecdn.net/files/5107/45/matmos-1.7.10-36.0.1.jar";
    hash = "sha256-B5MsNO6Z0sXo6BnxKgXtI/HLSnw9xIeDqiEBy2Cb5J8=";
  };

  dynamic-surroundings = fetchurl {
    url = "https://mediafilez.forgecdn.net/files/2642/381/DynamicSurroundings-1.7.10-1.0.6.4.jar";
    hash = "sha256-bLU/TZaywWW98RCVq43UagfMZiod1cc8WVc6UztY2fI=";
  };

in
stdenv.mkDerivation {
  inherit src version;
  pname = "gtnh-client";

  nativeBuildInputs = [ unzip ];

  installPhase = ''
    cp -rTv --no-preserve mode "$src/GT New Horizons ${version}" $out

    cp -rTv ${./resources/resourcepacks} $out/.minecraft/resourcepacks
    cp -rTv ${./resources/shaderpacks} $out/.minecraft/shaderpacks

    cp -v ${foamfix} ${matmos} ${dynamic-surroundings} $out/.minecraft/mods
  '';
}
