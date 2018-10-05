{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, ninja, vala, glib, gtk3
, libgee, desktop-file-utils, dbus-glib, geoclue2, gobjectIntrospection, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "pantheon-agent-geoclue2";
  version = "1e449f65abb0565b7138e45ee09ae1b40df4f95a";

  name = "${pname}-2018-09-25";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1krfhyg9m05nnkqbf9bc9rvs1755970qggzx9znn62ipwaqpk188";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
    };
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
