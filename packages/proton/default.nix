{ pkgs }: {
  inherit (pkgs) proton-ge-bin;

  ge-proton8-16 = pkgs.proton-ge-bin.overrideAttrs (prev: { # #
    version = "GE-Proton8-16";
    src = pkgs.fetchzip {
      inherit (prev.src) url;
      hash = "sha256-75A0VCVdYkiMQ1duE9r2+DLBJzV02vUozoVLeo/TIWQ=";
    };
  });

  ge-proton8-25 = pkgs.proton-ge-bin.overrideAttrs (prev: { # #
    version = "GE-Proton8-25";
    src = pkgs.fetchzip {
      inherit (prev.src) url;
      hash = "sha256-IoClZ6hl2lsz9OGfFgnz7vEAGlSY2+1K2lDEEsJQOfU=";
    };
  });
}
