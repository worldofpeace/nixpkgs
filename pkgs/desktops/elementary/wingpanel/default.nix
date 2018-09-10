{ mkElementary,  wrapGAppsHook, pkgconfig, cmake, vala, gala, gtk3
, libgee, granite, gettext, appstream-glib, glib-networking, mutter
, json-glib, appstream, defaultIconTheme, gobjectIntrospection }:

mkElementary rec {
  pname = "wingpanel";
  version = "628412171cd502e06cc416607b8d614bed3d0577";

  name = "${pname}-2018-09-10";

  sha256 = "1z3wgi9jvcsv869sx87rn84mw8s7b57pzsq7aaji42gk11vbm7lm";

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
    granite
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
