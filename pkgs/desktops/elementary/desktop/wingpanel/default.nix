{ mkElementary, pkgconfig, cmake, vala, gala, gtk3, libgee
, glib, granite, gettext, appstream-glib, gsettings-desktop-schemas
, defaultIconTheme, wrapGAppsHook, gobjectIntrospection, appstream
, glib-networking, gdk_pixbuf, mutter, json-glib }:

mkElementary rec {
  pname = "wingpanel";
  version = "2.1.1";

  name = "${pname}-${version}";

  sha256 = "14hbi2yv7c198d1q4hir3z3ywax44zhx5qx07jcz7ldmjsji42mh";

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

  patches = [ ./indicators-dir.patch ];

  meta = {
    description = "The extensible top panel for Pantheon";
    longDescription = ''
      Wingpanel is an empty container that accepts indicators as extensions,
      including the applications menu.
    '';
  };
}
