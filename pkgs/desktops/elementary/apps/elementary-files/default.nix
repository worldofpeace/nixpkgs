{ mkElementary, pkgconfig, cmake, vala, libcanberra, dbus-glib
, gtk3, libgee, glib, granite, libnotify, pango, plank, sqlite
, libdbusmenu-gtk3, zeitgeist, gettext, glib-networking, intltool
, gsettings-desktop-schemas, defaultIconTheme, wrapGAppsHook, gobjectIntrospection }:

mkElementary rec {
  pname = "files";
  version = "bcec2449615011e41093734d73546e4f3fcc09b7";

  name = "elementary-${pname}-2018-08-15";

  sha256 = "1cl4kjjjnnqrgaa40xbjs6lbzwblyk6vbb2migzi6vp497hqbdbp";

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
