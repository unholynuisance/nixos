{ pkgs }:

let
  ge-proton =
    {
      version,
      hash,
      steamDisplayName,
    }:
    let
      pkg' = pkgs.proton-ge-bin.overrideAttrs (prev: {
        inherit version;
        src = pkgs.fetchzip {
          inherit hash;
          inherit (prev.src) url;
        };
      });

      pkg'' = pkg'.override (prev: {
        inherit steamDisplayName;
      });
    in
    pkg'';
in

{
  inherit (pkgs) proton-ge-bin;

  ge-proton8-16 = ge-proton {
    version = "GE-Proton8-16";
    hash = "sha256-75A0VCVdYkiMQ1duE9r2+DLBJzV02vUozoVLeo/TIWQ=";
    steamDisplayName = "GE-Proton 8-16";
  };

  ge-proton8-25 = ge-proton {
    version = "GE-Proton8-25";
    hash = "sha256-IoClZ6hl2lsz9OGfFgnz7vEAGlSY2+1K2lDEEsJQOfU=";
    steamDisplayName = "GE-Proton 8-25";
  };

  ge-proton10-26 = ge-proton {
    version = "GE-Proton10-26";
    hash = "sha256-Q5bKTDn3sTgp4mbsevOdN3kcdRsyKylghXqM2I2cYq8=";
    steamDisplayName = "GE-Proton 10-26";
  };

  ge-proton10-30 = ge-proton {
    version = "GE-Proton10-30";
    hash = "sha256-YZ+v+dzO70qTs3JxOAk9n7ByIYb3r8SeJBWnzjKQwuQ=";
    steamDisplayName = "GE-Proton 10-30";
  };
}
