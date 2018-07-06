{ mkElementary, lib, pkgconfig, meson, ninja, vala, substituteAll
, desktop-file-utils, gettext, libxml2, glib, gtk3
, granite, libgee, gsettings-desktop-schemas, gobjectIntrospection
, defaultIconTheme, appstream, editorconfig-core-c, gtksourceview3
, gtkspell3, libpeas, libsoup, vte, webkitgtk, zeitgeist, ctags
, libgit2-glib, intltool, wrapGAppsHook }:

mkElementary rec {
  pname = "code";
  version = "6ea55ad137df4b81c5fae0a8c745bb0cd110d505";

  name = "elementary-${pname}-2018-06-25";
  
  sha256 = "0vha25mp0xhb1m1927h920nhnalicgrkz8qqfi5fl1d2c915wvxg";

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
