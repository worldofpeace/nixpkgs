{ mkElementary, cmake, pkgconfig, vala, granite, libgee, gettext
, gtk3, glib, appstream, gnome-menus, json-glib, plank, bamf
, switchboard, libunity, libsoup, wingpanel, libwnck3, zeitgeist
, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "applications-menu";
  version = "2.3.0";

  name = "wingpanel-${pname}-${version}";

  sha256 = "05n7qn64a4a2fmikhvg3pqvfdav0qnnnmvpzvz6ihfd2ifqg432k";

  nativeBuildInputs = [ 
    appstream
    cmake
    gettext
    gobjectIntrospection
    pkgconfig
    vala
    wrapGAppsHook
   ];

  buildInputs = [
    bamf
    defaultIconTheme
    glib
    gnome-menus
    granite
    gtk3
    json-glib
    libgee
    libsoup
    libunity
    libwnck3
    plank
    switchboard
    wingpanel
    zeitgeist
   ];


  PKG_CONFIG_WINGPANEL_2_0_INDICATORSDIR = "lib/wingpanel";
  PKG_CONFIG_SWITCHBOARD_2_0_PLUGSDIR = "lib/switchboard";

  patches = [ ./xdg.patch ];

  meta = {
    description = "Lightweight and stylish app launcher for Pantheon";
  };
}
