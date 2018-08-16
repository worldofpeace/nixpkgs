{ mkElementary, pkgconfig, fetchpatch, meson, ninja
, vala, desktop-file-utils, gettext, libxml2, glib, gtk3
, granite, libnotify, vte, libgee, gsettings-desktop-schemas
, gobjectIntrospection, defaultIconTheme, appstream, wrapGAppsHook }:

mkElementary rec {
  pname = "terminal";
  version = "0.5.1";

  name = "elementary-${pname}-${version}";

  sha256 = "05iki20y2swlpjrvccfsn1sag6yl95wrfb3rafd0p2gix39il8la";

  nativeBuildInputs = [
    appstream
    desktop-file-utils
    gettext
    gobjectIntrospection
    libxml2
    meson
    ninja
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    defaultIconTheme
    glib
    granite
    gsettings-desktop-schemas
    gtk3
    libgee
    libnotify
    vte
  ];

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py
  '';

  meta = {
    description = "Terminal emulator designed for elementary OS";
    longDescription = ''
      A super lightweight, beautiful, and simple terminal. Comes with sane defaults, browser-class tabs, sudo paste protection,
      smart copy/paste, and little to no configuration.
    '';
  };
}
