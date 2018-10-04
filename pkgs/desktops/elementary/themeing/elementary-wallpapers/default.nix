{ stdenv, fetchFromGitHub, elementary }:

stdenv.mkDerivation rec {
  pname = "wallpapers";
  version = "337bd28558fd0c716b581925bfbde0620b8df994";

  name = "elementary-${pname}-2018-08-15";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1kh63ixcw697fac8rplj7dckpmiakipkqb13pa53br73c8y6zbxf";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
      attrPath = "elementary-${pname}";
    };
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/backgrounds/elementary
    cp -av *.jpg $out/share/backgrounds/elementary
  '';

  meta = with stdenv.lib; {
    description = "Collection of wallpapers for elementary";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.publicDomain;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}

