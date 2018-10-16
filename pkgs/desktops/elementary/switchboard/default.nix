{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, python3, ninja
, vala, gtk3, libgee, granite, gettext, clutter-gtk, libunity, intltool
, defaultIconTheme, wrapGAppsHook, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard";
  version = "2.3.4";

  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "08g9rplx5d2nwh1j1m632bjbgb84qb96qi9qs964112na01qg4c7";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
    };
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
