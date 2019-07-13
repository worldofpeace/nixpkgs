{ stdenv, fetchFromGitHub, pkgconfig, autoreconfHook, wrapGAppsHook
, gtk3, vala, xorg, lightdm, gettext, intltool, glib, libcanberra, cairo, pixman, gnome3 }:

stdenv.mkDerivation rec {
  pname = "slick-greeter";
  version = "1.2.6";

  src = fetchFromGitHub {
    owner = "linuxmint";
    repo = pname;
    rev = version;
    sha256 = "1x27c1fm5dpfa2yzlb9wp66wsq6ym1m81k5kg94c8h5az3xh9s44";
  };

  nativeBuildInputs = [
    pkgconfig
    wrapGAppsHook
    vala
    intltool
    autoreconfHook
  ];

  buildInputs = [
    gtk3
    glib
    cairo
    xorg.libX11
    xorg.libXext
    pixman
    lightdm
    libcanberra
  ];

  postPatch = ''
    substituteInPlace src/Makefile.am \
      --replace "sbin_PROGRAMS" "bin_PROGRAMS"
  '';

  preConfigure = ''
    aclocal --install
    autoreconf -vfi
    intltoolize -f
  '';

  meta = with stdenv.lib; {
    description = "A slick-looking LightDM greeter";
    homepage = "https://github.com/linuxmint/slick-greeter";
    platforms = platforms.linux;
    license = licenses.gpl3;
    maintainers = with maintainers; [
      worldofpeace
    ];
  };
}
