{ pkgs }:
{
  inherit (pkgs) proton-ge-bin;

  ge-proton8-16 =
    let
      pkg' = pkgs.proton-ge-bin.overrideAttrs (prev: {
        version = "GE-Proton8-16";
        src = pkgs.fetchzip {
          inherit (prev.src) url;
          hash = "sha256-75A0VCVdYkiMQ1duE9r2+DLBJzV02vUozoVLeo/TIWQ=";
        };
      });

      pkg'' = pkg'.override (prev: {
        steamDisplayName = "GE-Proton 8-16";
      });
    in
    pkg'';

  ge-proton8-25 =
    let
      pkg' = pkgs.proton-ge-bin.overrideAttrs (prev: {
        version = "GE-Proton8-25";
        src = pkgs.fetchzip {
          inherit (prev.src) url;
          hash = "sha256-IoClZ6hl2lsz9OGfFgnz7vEAGlSY2+1K2lDEEsJQOfU=";
        };
      });

      pkg'' = pkg'.override (prev: {
        steamDisplayName = "GE-Proton 8-25";
      });
    in
    pkg'';

  ge-proton10-26 =
    let
      pkg' = pkgs.proton-ge-bin.overrideAttrs (prev: {
        version = "GE-Proton10-26";
        src = pkgs.fetchzip {
          inherit (prev.src) url;
          hash = "sha256-Q5bKTDn3sTgp4mbsevOdN3kcdRsyKylghXqM2I2cYq8=";
        };
      });

      pkg'' = pkg'.override (prev: {
        steamDisplayName = "GE-Proton 10-26";
      });
    in
    pkg'';
}
