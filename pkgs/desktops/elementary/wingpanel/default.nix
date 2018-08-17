{ mkElementary, pkgconfig, cmake, vala, gala, gtk3, libgee
, glib, granite, gettext, appstream-glib, gsettings-desktop-schemas
, defaultIconTheme, wrapGAppsHook, gobjectIntrospection, appstream
, glib-networking, gdk_pixbuf, mutter, json-glib }:

mkElementary rec {
  pname = "wingpanel";
  version = "6e7163ba09d5247d6759fc96037441a4afcb2c97";

  name = "${pname}-2018-07-24";

  sha256 = "1jnx55gnly4q8ihlwq4q9zspan5isvxdl8cpqrspqwg6xhap5slh";

  nativeBuildInputs = [
    appstream
    appstream-glib
    cmake
    gettext
    glib-networking
    gobjectIntrospection
    pkgconfig
    vala
    wrapGAppsHook
  ];

  buildInputs = [
    gala
    gdk_pixbuf
    glib
    granite
    gsettings-desktop-schemas
    gtk3
    json-glib
    libgee
    mutter
  ];

  patches = [ ./indicators.patch ./pkgconfig.patch ];

  meta = {
    description = "The extensible top panel for Pantheon";
    longDescription = ''
      Wingpanel is an empty container that accepts indicators as extensions,
      including the applications menu.
    '';
  };
}
