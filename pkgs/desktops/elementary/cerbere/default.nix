{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, python3, ninja, glib, libgee, vala, gobjectIntrospection, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "cerbere";
  version = "0.2.4";

  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0f9jr6q5z6nir5b77f96wm9rx6r6s9i0sr1yrymg3n7jyjgrvdwp";
  };

  nativeBuildInputs = [
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    glib
    libgee
  ];

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "A simple service to ensure uptime of essential processes";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };

}
