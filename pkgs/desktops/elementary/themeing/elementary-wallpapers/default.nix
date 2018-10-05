{ stdenv, fetchFromGitHub, elementary }:

stdenv.mkDerivation rec {
  pname = "wallpapers";
  version = "d45586cf1e18f5941141190aa98b6eafc089e217";

  name = "elementary-${pname}-2018-10-05";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1rhi8f3rqlavwzhbnw0vs802bmih209gxiv8fdn01vv3cp4kls27";
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

