{ stdenv, fetchurl, intltool, itstool, libxml2, yelp }:

stdenv.mkDerivation rec {
  pname = "mate-user-guide";
  version = "1.24.0";

  src = fetchurl {
    url = "https://pub.mate-desktop.org/releases/${stdenv.lib.versions.majorMinor version}/${pname}-${version}.tar.xz";
    sha256 = "0ddxya84iydvy85dbqls0wmz2rph87wri3rsdhv4rkbhh5g4sd7f";
  };

  nativeBuildInputs = [ itstool intltool libxml2 ];

  buildInputs = [ yelp ];

  meta = with stdenv.lib; {
    description = "MATE User Guide";
    homepage = "https://mate-desktop.org";
    license = with licenses; [ gpl2Plus fdl12 ];
    platforms = platforms.unix;
    maintainers = [ maintainers.romildo ];
  };
}
