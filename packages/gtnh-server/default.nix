{
  lib,
  stdenv,
  fetchurl,
  unzip,
  jdk20,
  ...
}: let
  server-utilities = fetchurl {
    url = "https://github.com/GTNewHorizons/ServerUtilities/releases/download/1.0.2/ServerUtilities-1.0.2.jar";
    hash = "";
  };
in
  stdenv.mkDerivation {
    pname = "gtnh-server";
    version = "3.4.0";
    src = fetchurl {
      url = "http://downloads.gtnewhorizons.com/ServerPacks/GT_New_Horizons_2.4.0_Server_Java_17-20.zip";
      hash = "";
    };

    nativeBuildInputs = [unzip];

    installPhase = ''
      mkdir -p $out/lib/gtnh-server
      mv -v $src/minecraft_server.1.7.10.jar $src/server.jar
      cp -v $src/* $out/lib/gtnh-server

      cp ${server-utilities} $out/lib/gtnh-server/mods

      mkdir -p $out/bin
      cat > $out/bin/minecraft-server << EOF
      #!/bin/sh
      exec ${jdk20}/bin/java \$@ -jar $out/lib/gthn-server/server.jar
      EOF

      chmod +x $out/bin/gtnh-server
    '';
  }
