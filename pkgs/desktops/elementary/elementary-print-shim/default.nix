{ stdenv, fetchFromGitHub, elementary, meson, ninja, pkgconfig, vala, gtk3 }:

stdenv.mkDerivation rec {
  pname = "print";
  version = "c92021f6b79536cea005d112a53e2bcaeb5ac88e";

  name = "elementary-print-shim-2018-07-10";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1l3l77jzqjmpr5p3mpmdi1jiv5364b3awsqn7i6ihn3n28wvdkbh";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
      attrPath = "elementary-${pname}-shim";
    };
  };

  nativeBuildInputs = [
    meson
    ninja
    pkgconfig
    vala
  ];

  buildInputs = [ gtk3 ];

  meta = with stdenv.lib; {
    description = "Simple shim for printing support via Contractor";
    homepage = "https://github.com/elementary/print";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
