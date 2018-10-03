{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, python3, ninja
, vala, gtk3, libgee, granite, gettext, clutter-gtk, libunity, intltool
, defaultIconTheme, wrapGAppsHook, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard";
  version = "0fc05c5422c934aab5c83307396a93b6f4cdd77c";

  name = "${pname}-2018-08-14";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0nvnbycd9iiy9zb89847nwbrlwb8s9ycir33n1fyb9hpqnamym2v";
  };

  nativeBuildInputs = [
    gettext
    gobjectIntrospection
    intltool
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    clutter-gtk
    defaultIconTheme
    granite
    gtk3
    libgee
    libunity
  ];

  patches = [ ./plugs-path-env.patch ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "Extensible System Settings app for Pantheon";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.lgpl21Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
