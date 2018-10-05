{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, python3, ninja
, vala, gtk3, libgee, granite, gettext, clutter-gtk, libunity, intltool
, defaultIconTheme, wrapGAppsHook, gobjectIntrospection }:

stdenv.mkDerivation rec {
  pname = "switchboard";
  version = "6682a0cfa791814fc777e696085a0d98a2407623";

  name = "${pname}-2018-10-04";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "14pw342qsflghc19fyswc1hn6jq17b8ijwm0ygz3xf1ysdf2lil0";
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
