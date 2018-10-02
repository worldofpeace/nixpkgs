{ mkElementary, pkgconfig, meson, ninja, vala
, desktop-file-utils, gtk3, granite, libgee, intltool
, libchamplain, clutter, folks, geocode-glib, python3
, libnotify, libical, evolution-data-server, appstream-glib
, defaultIconTheme, gobjectIntrospection, wrapGAppsHook }:

mkElementary rec {
  pname = "calendar";
  version = "88a9c4e13b09804bc93777e4ad0fb97824f3709c";

  name = "elementary-${pname}-2018-09-30";

  sha256 = "1bavvljwm091cj4x2awbv6kv0vp9igcfilc04dk76i4jr10vpzzz";

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

  meta = {
    description = "Desktop calendar app designed for elementary OS";
  };
}
