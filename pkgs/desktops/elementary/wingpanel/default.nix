{ mkElementary,  wrapGAppsHook, pkgconfig, cmake, ninja, vala, gala
, gtk3, libgee, granite, gettext, appstream-glib, glib-networking
, mutter, json-glib, appstream, defaultIconTheme, gobjectIntrospection }:

mkElementary rec {
  pname = "wingpanel";
  version = "c0e3cab95a8deb0108dd717c2fa7e08a90175f6b";

  name = "${pname}-2018-10-01";

  sha256 = "0p64ygkcz7w3ynx3bhlmf15zgh9lcmlbi1gwkz3zpf3qg4j9g3g8";

  nativeBuildInputs = [
    appstream
    appstream-glib
    cmake
    gettext
    glib-networking
    gobjectIntrospection
    ninja
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
