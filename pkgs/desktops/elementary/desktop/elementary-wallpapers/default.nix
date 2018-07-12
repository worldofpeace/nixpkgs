{ mkElementary }:

mkElementary rec {
  pname = "wallpapers";
  version = "5.2";

  name = "elementary-${pname}-${version}";

  sha256 = "10cmw1258ir646c8kzsmvr1gim6xfhj1srzi8zqvlqshn8gp1140";

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/backgrounds/elementary
    cp -av *.jpg $out/share/backgrounds/elementary
  '';

  meta = {
    description = "Collection of wallpapers for elementary";
  };
}

