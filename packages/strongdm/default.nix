{
  # Snowfall Lib provides a customized `lib` instance with access to your flake's library
  # as well as the libraries available from your flake's inputs.
  lib,
  # You also have access to your flake's inputs.
  inputs,

  # The namespace used for your flake, defaulting to "internal" if not set.
  namespace,

  # All other arguments come from NixPkgs. You can use `pkgs` to pull packages or helpers
  # programmatically or you may add the named attributes as arguments here.
  pkgs,
  stdenv,
  ...
}:
stdenv.mkDerivation {
  name = "strongdm";
  version = "46.0.0";
  src = pkgs.fetchurl {
    url = "https://downloads.strongdm.com/builds/sdm-cli/46.0.0/linux-amd64/3A0E77B07D25D71873C733177236C027C9AFFD3B/sdmcli_46.0.0_linux_amd64.zip";
    sha256 = "63DA2CB006E804B98DC8B43C44D94B6843A79977B4C2DCD4A8F69BE15D8EE0B7";
  };
  buildInputs = [ pkgs.unzip ];
  unpackPhase = ''
    unzip $src
  '';
  installPhase = ''
    mkdir -p $out/bin
    mv ./sdm $out/bin
  '';
  nativeBuildInputs = [ pkgs.autoPatchelfHook ];
}
