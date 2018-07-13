{ mkElementary, pkgconfig, cmake, vala, gtk3, libgee
, glib, granite, gettext, clutter-gtk, libunity, gsettings-desktop-schemas
, intltool, defaultIconTheme, wrapGAppsHook, gobjectIntrospection }:

mkElementary rec {
  pname = "switchboard";
  version = "2.3.1";

  name = "${pname}-${version}";

  sha256 = "00rhaz7d5i7wbm5hy7h9xmcbxhsx42c93l04a4bykxy5ri1i6cg2";

  nativeBuildInputs = [
    cmake
    gettext
    gobjectIntrospection
    intltool
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    clutter-gtk
    defaultIconTheme
    glib
    granite
    gsettings-desktop-schemas
    gtk3
    libgee
    libunity
  ];

  patches = [ ./plugins-dir.patch ];

  meta = {
    description = "Extensible System Settings app Pantheon";
  };
}
