{ mkElementary, lib, pkgconfig, meson, ninja, vala, substituteAll
, desktop-file-utils, gettext, libxml2, glib, gtk3, granite, libgee
, gsettings-desktop-schemas, gobjectIntrospection, defaultIconTheme
, appstream, editorconfig-core-c, gtksourceview3, gtkspell3, libpeas
, libsoup, vte, webkitgtk, zeitgeist, ctags, libgit2-glib, intltool, wrapGAppsHook }:

mkElementary rec {
  pname = "code";
  version = "959b5715b1e5c08fc3ab61d8ba7d65bf991052b2";

  name = "elementary-${pname}-2018-08-12";

  sha256 = "1jdaqvsg6v5wvnkbxfa6nva97k0ajxx5nrvkb9fli17zsb9g0g6w";

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
    ctags
    defaultIconTheme
    editorconfig-core-c
    glib
    granite
    gsettings-desktop-schemas
    gtk3
    gtksourceview3
    gtkspell3
    intltool
    libgee
    libgit2-glib
    libpeas
    libsoup
    vte
    webkitgtk
    zeitgeist
  ];

  patches = [
    (substituteAll {
      src = ./ctags.patch;
      ctags = "${ctags}/bin/ctags";
    })
  ];


  LIBRARY_PATH = lib.makeLibraryPath [ editorconfig-core-c ];

  postPatch = ''
    chmod +x ./meson/post_install.py
    patchShebangs ./meson/post_install.py
  '';

  meta = {
    description = "Code editor designed for elementary OS";
  };
}
