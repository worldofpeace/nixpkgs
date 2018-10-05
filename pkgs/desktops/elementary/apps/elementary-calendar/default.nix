{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson
, ninja, vala, desktop-file-utils, gtk3, granite, libgee
, intltool, libchamplain, clutter, folks, geocode-glib, python3
, libnotify, libical, evolution-data-server, appstream-glib
, defaultIconTheme, gobjectIntrospection, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "calendar";
  version = "196bae9e75088a8549e49f9f3d3bd5612fe1b22c";

  name = "elementary-${pname}-2018-10-05";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "0240y2aljqlcmf0fn1q8ca1vdvz4rvr8jd0ifqvjcmk7z3pk40im";
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
