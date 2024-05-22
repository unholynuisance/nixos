{ stdenv, version, hash, jdk ? jdk21, jdk21, writeShellScript, fetchzip, unzip
}:
let
  src = fetchzip {
    inherit hash;
    url =
      "https://downloads.gtnewhorizons.com/ServerPacks/GT_New_Horizons_${version}_Server_Java_17-21.zip";
    stripRoot = false;
  };

  startScript = writeShellScript "minecraft-start" ''
    exec ${jdk}/bin/java $@ -Dfml.readTimeout=180 @java9args.txt -jar lwjgl3ify-forgePatches.jar nogui
  '';

  stopScript = writeShellScript "minecraft-stop" ''
    echo stop > "$2"

    # Wait for the PID of the minecraft server to disappear before
    # returning, so systemd doesn't attempt to SIGKILL it.
    while kill -0 "$1" 2> /dev/null; do
      sleep 1s
    done
  '';

in stdenv.mkDerivation {
  inherit src version;
  pname = "gtnh-server";

  nativeBuildInputs = [ unzip ];

  installPhase = ''
    mkdir -p $out/lib/minecraft
    cp -rTv --no-preserve mode $src/ $out/lib/minecraft

    mkdir -p $out/bin
    cp -v ${startScript} $out/bin/minecraft-start
    cp -v ${stopScript} $out/bin/minecraft-stop
  '';
}
