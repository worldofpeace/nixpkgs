{ mkElementary, pkgconfig, fetchpatch, meson, ninja
, vala, desktop-file-utils, gettext, libxml2, glib, gtk3
, granite, libnotify, vte, libgee, gsettings-desktop-schemas
, gobjectIntrospection, defaultIconTheme, appstream, wrapGAppsHook }:

mkElementary rec {
  pname = "terminal";
  version = "0.5";

  name = "elementary-${pname}-${version}";

  sha256 = "1r06kqghylnlw8hl8h4ffsak8il7gg99daic3j15byf322lms508";

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

  patches = [
    # Fix API breaks with VTE > 2.91
    (fetchpatch {
      url = https://github.com/elementary/terminal/commit/8a87b497f6d64c7a7c1ce2bcec176d467976faf6.patch;
      sha256 = "13ac6qyg35v4sc0dlc243n6rrck4bqnysfg65lzrq93m4j2j1pdv";
    })
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
