{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson
, ninja, vala, desktop-file-utils, gtk3, granite, libgee
, intltool, libchamplain, clutter, folks, geocode-glib, python3
, libnotify, libical, evolution-data-server, appstream-glib
, defaultIconTheme, gobjectIntrospection, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "calendar";
  version = "88a9c4e13b09804bc93777e4ad0fb97824f3709c";

  name = "elementary-${pname}-2018-09-30";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "1bavvljwm091cj4x2awbv6kv0vp9igcfilc04dk76i4jr10vpzzz";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
      attrPath = "elementary-${pname}";
    };
  };

  nativeBuildInputs = [
    appstream-glib
    desktop-file-utils
    gobjectIntrospection
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    clutter
    defaultIconTheme
    evolution-data-server
    folks
    geocode-glib
    granite
    gtk3
    libchamplain
    libgee
    libical
    libnotify
  ];

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "Desktop calendar app designed for elementary OS";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
