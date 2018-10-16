{ stdenv, fetchFromGitHub, elementary, pkgconfig, meson, ninja, vala, substituteAll
, python3, glibcLocales, desktop-file-utils, gtk3, granite, libgee, defaultIconTheme
, appstream, libpeas, editorconfig-core-c, gtksourceview3, gtkspell3, libsoup
, vte, webkitgtk, zeitgeist, ctags, libgit2-glib, intltool, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "code";
  version = "3.0";

  name = "elementary-${pname}-${version}";

  src = fetchFromGitHub {
    owner = "elementary";
    repo = pname;
    rev = version;
    sha256 = "01hz2hrcwn7l2vrsp8i6xcalq8zcnia77flpz1f7x7fpi60w6d8j";
  };

  passthru = {
    updateScript = elementary.updateScript {
      repoName = pname;
      attrPath = "elementary-${pname}";
    };
  };

  nativeBuildInputs = [
    appstream
    desktop-file-utils
    glibcLocales
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

  LIBRARY_PATH = stdenv.lib.makeLibraryPath [ editorconfig-core-c ];

  # install script fails with UnicodeDecodeError because of printing a fancy elipsis character
  LC_ALL = "en_US.UTF-8";

  postPatch = ''
    chmod +x meson/post_install.py
    patchShebangs meson/post_install.py
  '';

  meta = with stdenv.lib; {
    description = "Code editor designed for elementary OS";
    homepage = "https://github.com/elementary/${pname}";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = elementary.maintainers;
  };
}
