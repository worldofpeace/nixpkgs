{ mkElementary }:

mkElementary rec {
  pname = "wallpapers";
  version = "337bd28558fd0c716b581925bfbde0620b8df994";

  name = "elementary-${pname}-2018-08-15";

  sha256 = "1kh63ixcw697fac8rplj7dckpmiakipkqb13pa53br73c8y6zbxf";

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/backgrounds/elementary
    cp -av *.jpg $out/share/backgrounds/elementary
  '';

  meta = {
    description = "Collection of wallpapers for elementary";
  };
}

