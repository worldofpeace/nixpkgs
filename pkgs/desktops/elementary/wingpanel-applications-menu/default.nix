{ mkElementary, cmake, ninja, pkgconfig, vala, granite, libgee
, gettext, gtk3, appstream, gnome-menus, json-glib, plank, bamf
, switchboard, libunity, libsoup, wingpanel, libwnck3, zeitgeist
, gobjectIntrospection, defaultIconTheme, wrapGAppsHook }:

mkElementary rec {
  pname = "applications-menu";
  version = "2.4.0";

  name = "wingpanel-${pname}-${version}";

  sha256 = "1irkjs0zm4pm5rpwg6p7jq5ml78z9mkv35j4754g7c6pps6jlg8l";

  nativeBuildInputs = [
    appstream
    cmake
    ninja
    gettext
    gobjectIntrospection
    pkgconfig
    vala
    wrapGAppsHook
   ];

  buildInputs = [
    bamf
    defaultIconTheme
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
