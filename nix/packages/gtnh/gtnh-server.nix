{
  fetchurl,
  version,
  url,
  hash,
}:
fetchurl {
  inherit version url hash;
  pname = "gtnh-server";
}
