{ lib, stdenv, fetchurl, fetchzip, unzip, jdk21, ... }:
let
  server-utilities = fetchurl {
    url =
      "https://github.com/GTNewHorizons/ServerUtilities/releases/download/1.0.2/ServerUtilities-1.0.2.jar";
    hash = "sha256-5sdOtCYm+Hg698Xlk4wZBsg43mRjMLd8LloAFN1YMb4=";
  };

in {
  mc-gtnh-server = stdenv.mkDerivation rec {
    pname = "mc-gtnh-server";
    version = "2.5.1";
    src = fetchzip {
      url =
        "https://downloads.gtnewhorizons.com/ServerPacks/GT_New_Horizons_${version}_Server_Java_17-21.zip";
      hash = "sha256-CNPws8OjFsNyLe2ZtJaWRd20qVTFf4r/9yKzvvkXlyY=";
      stripRoot = false;
    };
    nativeBuildInputs = [ unzip ];

    installPhase = ''
      mkdir -p $out/lib/mc-gtnh-server
      cp -rTv --no-preserve mode $src/ $out/lib/mc-gtnh-server
      cp -v ${server-utilities} $out/lib/mc-gtnh-server/mods/

      mkdir -p $out/bin
      cat > $out/bin/mc-gtnh-server-start << EOF
      #!/bin/sh
      exec ${jdk21}/bin/java \$@ -Dfml.readTimeout=180 @java9args.txt nogui
      EOF

      cat > $out/bin/mc-gtnh-server-stop << EOF
      #!/bin/sh
      echo stop > "\$2"

      # Wait for the PID of the minecraft server to disappear before
      # returning, so systemd doesn't attempt to SIGKILL it.
      while kill -0 "\$1" 2> /dev/null; do
        sleep 1s
      done
      EOF

      chmod +x $out/bin/mc-gtnh-server-start
      chmod +x $out/bin/mc-gtnh-server-stop
    '';
  };

  mc-gtnh-client = stdenv.mkDerivation rec {
    pname = "mc-gtnh-client";
    version = "2.5.1";
    src = fetchzip {
      url =
        "https://downloads.gtnewhorizons.com/Multi_mc_downloads/GT_New_Horizons_${version}_Java_17-21.zip";
      hash = "sha256-y0SqMIt/PToBEtTnWWgYQWNeUH+t8FWh/u3K5ad8lGI=";
      stripRoot = false;
    };
    nativeBuildInputs = [ unzip ];
    installPhase = ''
      cp -rTv --no-preserve mode "$src/GT New Horizons ${version}" $out

      cp -v ${server-utilities} $out/.minecraft/mods

      cp -v ${./resources/options.txt} $out/.minecraft/options.txt
      cp -v ${./resources/optionsof.txt} $out/.minecraft/optionsof.txt
      cp -v ${./resources/optionsshaders.txt} $out/.minecraft/optionsshaders.txt

      cp -rTv ${./resources/resourcepacks} $out/.minecraft/resourcepacks
      cp -rTv ${./resources/shaderpacks} $out/.minecraft/shaderpacks
    '';
  };
}
