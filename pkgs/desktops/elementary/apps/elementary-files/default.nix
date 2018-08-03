{ mkElementary, pkgconfig, cmake, vala, libcanberra, dbus-glib
, gtk3, libgee, glib, granite, libnotify, pango, plank, sqlite
, libdbusmenu-gtk3, zeitgeist, gettext, glib-networking, intltool
, gsettings-desktop-schemas, defaultIconTheme, wrapGAppsHook, gobjectIntrospection }:

mkElementary rec {
  pname = "files";
  version = "319e2b9c3ebcb06e2e2afcbad8df071b8c2d08db";

  name = "elementary-${pname}-2018-06-09";

  sha256 = "0azgmp1yysja6pxwd57ycgfir28kj7ar7f7chr88ndqzx71fkgvq";

  nativeBuildInputs = [
    cmake
    gettext
    glib-networking
    gobjectIntrospection
    intltool
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    dbus-glib
    defaultIconTheme
    glib
    granite
    gsettings-desktop-schemas
    gtk3
    libcanberra
    libdbusmenu-gtk3
    libgee
    libnotify
    pango
    plank
    sqlite
    zeitgeist
  ];

  patches = [ ./hardcode-gsettings.patch ];

  postPatch = ''
    substituteInPlace filechooser-module/FileChooserDialog.vala --subst-var-by ELEMENTARY_FILES_GSETTINGS_PATH $out/share/gsettings-schemas/${name}/glib-2.0/schemas
  '';

  meta = {
    description = "File browser designed for elementary OS";
  };
}
