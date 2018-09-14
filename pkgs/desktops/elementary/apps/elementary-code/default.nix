{ mkElementary, lib, pkgconfig, meson, ninja, vala, substituteAll, python3
, desktop-file-utils, gtk3, granite, libgee, defaultIconTheme, appstream
, libpeas, editorconfig-core-c, gtksourceview3, gtkspell3, libsoup, vte
, webkitgtk, zeitgeist, ctags, libgit2-glib, intltool, wrapGAppsHook }:

mkElementary rec {
  pname = "code";
  version = "74e42c3a280314f03652b43673be11c299152f3f";

  name = "elementary-${pname}-2018-09-06";

  sha256 = "0g9va1f7p8fq7kkfg096yzmm4pjxxf4b2dsy1wblahk8svb4x3bx";

  nativeBuildInputs = [
    appstream
    desktop-file-utils
    meson
    ninja
    pkgconfig
    python3
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    ctags
    defaultIconTheme
    editorconfig-core-c
    granite
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
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = {
    description = "Code editor designed for elementary OS";
  };
}
