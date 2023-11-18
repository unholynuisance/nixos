{
  lib,
  stdenv,
  fetchurl,
  fetchzip,
  unzip,
  jdk21,
  ...
}: let
  server-utilities = fetchurl {
    url = "https://github.com/GTNewHorizons/ServerUtilities/releases/download/1.0.2/ServerUtilities-1.0.2.jar";
    hash = "sha256-5sdOtCYm+Hg698Xlk4wZBsg43mRjMLd8LloAFN1YMb4=";
  };

  mc-gtnh-server-src = fetchzip {
    url = "https://downloads.gtnewhorizons.com/ServerPacks/GT_New_Horizons_2.4.0_Server_Java_17-20.zip";
    hash = "sha256-2OtwaJuAa83u9iyMGKfeOUgJlqxsFtKVdTA4dliCBnQ=";
    stripRoot = false;
  };

  mc-gtnh-client-src = fetchzip {
    url = "https://downloads.gtnewhorizons.com/Multi_mc_downloads/GT_New_Horizons_2.4.0_Java_17-20.zip";
    hash = "sha256-18ek/jTlTOnaBa1MUy7qyyffzeaBSynCJHYRJJVAt10=";
    stripRoot = false;
  };
in {
  mc-gtnh-server = stdenv.mkDerivation {
    pname = "mc-gtnh-server";
    version = "2.4.0";
    src = mc-gtnh-server-src;
    nativeBuildInputs = [unzip];

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
    version = "2.4.0";
    src = mc-gtnh-client-src;
    nativeBuildInputs = [unzip];
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
