{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, ninja, vala, glib, gtk3
, libgee, desktop-file-utils, dbus-glib, geoclue2, gobjectIntrospection, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "pantheon-agent-geoclue2";
  version = "1.0";

  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0m7wbyqqivfwpd2m4jcxg4vl3vmfxkj7285h283p9m6nfh9vz960";
  };

  nativeBuildInputs = [
    desktop-file-utils
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
   ];

  buildInputs = [
    dbus-glib
    geoclue2
    glib
    gtk3
    libgee
   ];

  # This should be provided by a post_install.py script
  postInstall = ''
    ${glib.dev}/bin/glib-compile-schemas $out/share/glib-2.0/schemas
  '';

  meta = with stdenv.lib; {
    description = "Pantheon Geoclue2 Agent";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
